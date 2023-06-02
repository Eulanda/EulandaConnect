Function Send-TelegramMessage {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string]$token
        ,
        [Parameter(Mandatory = $false)]
        [Alias("eToken")]
        [string]$encryptedToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("sToken")]
        [securestring]$secureToken
        ,
        [Alias("path")]
        [Parameter(Mandatory = $false)]
        [string]$pathToToken
        ,
        [Parameter(Mandatory = $false)]
        [Alias("id")]
        [String]$chatId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'chatId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [String]$message = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'message', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('html', 'markdown')]
        [Alias("mode")]
        [String]$parseMode = 'html'
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noNotify")]
        [Switch]$disableNotification
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleToken) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($secureToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString $secureToken -AsPlainText
                } elseif ($encryptedToken) {
                    [string]$token = ConvertFrom-SecureString -SecureString (ConvertTo-SecureString -String $encryptedToken) -AsPlainText
                }
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                if ($pathToToken) {
                    [securestring]$secureToken = Import-Clixml -Path $pathToToken
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($secureToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureToken)
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                } elseif ($encryptedToken) {
                    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((ConvertTo-SecureString -String $encryptedToken))
                    [string]$token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
                }
            }

            Set-Tls
            [string]$disableNotificationText = if ($disableNotification) { "true" } else { "false" }
            $response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage?chat_id=$chatId&text=$message&parse_mode=$parseMode&DisableNotification=$disableNotificationText"
            $result = $response.ok
        }

        catch {
            $result = $false
            Write-Error ((Get-ResStr 'TELEGRAM_SEND_MESSAGE_ERROR') -f $_)
        }

        finally {
            # Purge token, because it contains plain text
            $token = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 50 | ForEach-Object { [char]$_ })
            Remove-Variable token
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

    <#
        Test:
        API-Doc: https://core.telegram.org/bots/api#senddocument

        $pathToToken = "$home\.eulandaconnect\secureTelegramToken.xml"
        $chatId = "-713022389"

        $markdownMessage = "This is a MARKDOWN *test* with encrypted token from EulandaConnect"
        Send-TelegramMessage -pathToToken $pathToToken -chatId $chatId -parseMode 'markdown' -message $markdownMessage

        $htmlMessage = "This is an HTML <b>test</b> with encrypted token from EulandaConnect"
        Send-TelegramMessage -pathToToken $pathToToken -chatId $chatId -message $htmlMessage
    #>
}
