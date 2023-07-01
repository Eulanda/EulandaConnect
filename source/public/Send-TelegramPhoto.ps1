function Send-TelegramPhoto() {
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
        [String]$caption = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'caption', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]  # could be a local file or an internet resource url
        [String]$uri = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'photoUri', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('html', 'markdown')]
        [Alias("mode")]
        [String]$parseMode = 'html'
        ,
        [Parameter(Mandatory = $false)]
        [Alias("noDetection")]
        [Switch]$disableContentTypeDetection
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
        [bool]$result = $false

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

            $formParams = @{
                chat_id                        = $chatId
                caption                        = $caption
                parse_mode                     = $parseMode
                disable_content_type_detection = $disableContentTypeDetection
                disable_notification           = $disableNotification
            }

            if ($uri -like 'http*') {
                $formParams.Add('photo', $uri)
            }
            else {
                $fileObject = Get-Item $uri -ErrorAction Stop
                $formParams.Add('photo', $fileObject)
            }

            $invokeParams = @{
                Uri         = "https://api.telegram.org/bot$token/sendPhoto"
                ErrorAction = 'Stop'
                Method      = 'Post'
            }

            if ($PsVersionTable.PsVersion.Major -gt 5) {
                # This part runs on PowerShell 6.x, 7.x
                $invokeParams.Add('Form', $formParams)
            } else {
                # This part runs on PowerShell 5.x, 6.x, 7.x
                # Requires multipart conversion for binary files
                $boundary = [System.Guid]::NewGuid().ToString()
                $form = Convert-ToMultipart -params $formParams -boundary $boundary
                $invokeParams.Add('ContentType', "multipart/form-data; boundary=`"$boundary`"")
                $invokeParams.Add('Body', $form)
            }

            Set-Tls
            $response = Invoke-RestMethod @invokeParams
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
        https://core.telegram.org/bots/api#sendphoto

        $pathToToken = "$home\.EulandaConnect\secureTelegramToken.xml"
        $chatId = "-713022389"
        Send-TelegramPhoto -pathToToken $pathToToken -chatId $chatId -caption "My simple öäüÖÄÜ caption..." -uri 'c:\temp\logo.png'
    #>
}
