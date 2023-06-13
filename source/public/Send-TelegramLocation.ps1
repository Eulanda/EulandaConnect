function Send-TelegramMap() {
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
        [ValidateRange(-90,90)]
        [Alias('lat')]
        [Single]$latitude
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange(-180,180)]
        [Alias('lon')]
        [Single]$longitude
        ,
        [Parameter(Mandatory = $false)]
        [ipaddress]$ip = $null
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

            if ((! $latitude) -and (! $latitude) -and (! $ip)) {
                $ip = Get-PublicIp
            }

            if ($ip) {
                Get-IpGeoInfo -ip $ip.IpAddressToString | Out-Null
                $latitude = $global:geoHashTable[$ip.IpAddressToString].data.lat
                $longitude = $global:geoHashTable[$ip.IpAddressToString].data.lon
            }

            $formParams = @{
                chat_id                 = $chatId
                latitude                = $Latitude
                longitude               = $Longitude
                disable_notification    = $disableNotification
            }


            $invokeParams = @{
                Uri         = "https://api.telegram.org/bot$token/sendLocation"
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
        https://core.telegram.org/bots/api#sendlocation

        $pathToToken = "$home\.EulandaConnect\secureTelegramToken.xml"
        $chatId = "-713022389"

        # Paris -lon 2.3522 -lat 48.8566
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId -lon 2.3522 -lat 48.8566

        # The longitude and latitude of the position of your router ofer Get-PublicIp
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId

        # The longitude and latitude of the position over an geo api
        Send-TelegramMap -pathToToken $pathToToken -chatId $chatId -ip '5.1.80.40'
    #>
}
