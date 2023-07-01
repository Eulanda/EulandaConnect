Function Send-FtpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps")]
        [string]$protocol = 'ftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 21
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$localFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$retryCount = 0

        if (! $remoteFile) {
            $remoteFile = $localFile
        }

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq "/") {
            $fullRemotePath = "/$remoteFile"
        } else {
            $fullRemotePath = "$($remoteFolder)/$remoteFile"
        }

        $fullLocalPath = Join-Path $localFolder $localFile

        if (! (Test-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder)) {
            New-FtpFolder -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder
        }

        while ($retryCount -lt $resumeRetries) {
            try {
                # Delete old file if exists, if its a younger we try to resume upload
                if (Test-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile ) {
                    $fileAge = Get-FtpFileAge -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                    # Resume works only if not older then 3 hours
                    if ($fileAge -gt $resumeAge) {
                        Remove-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                        Write-Verbose ((Get-ResStr 'REMOTEFILE_TO_OLD_TO_RESUME') -f $remoteFile, $myInvocation.Mycommand)
                        $fileAge = 0
                    }
                } else {
                    $fileAge = 0
                }
                if ($fileAge -gt 0) {
                    $remoteFileSize = Get-FtpFileSize -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                } else {
                    $remoteFileSize = 0
                }
                $localFileSize = (Get-Item $fullLocalPath).Length
                Write-Verbose "Local Filesize: $localFileSize"
                Write-Verbose "Remote file size: $remoteFileSize"

                # Delete when remote has greater file size
                if ($remoteFileSize -gt $localFileSize) {
                    Remove-FtpFile -server $server -protocol $protocol -port $port -activeMode:$activeMode -user $user -password $password -remoteFolder $remoteFolder -remoteFile $remoteFile
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_TO_BIG_TO_RESUME') -f $remoteFile, $myInvocation.Mycommand)
                    $fileAge = 0
                }

                if ($fileAge) {
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_IS_RESUMING') -f $localFile, $myInvocation.Mycommand)

                    if ($remoteFileSize -lt $localFileSize) {
                        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$fullRemotePath")

                        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
                        $ftpRequest.UseBinary = $true
                        $ftpRequest.KeepAlive = $false

                        if ($protocol -eq 'ftps') {
                            $ftpRequest.EnableSsl = $true
                        } else {
                            $ftpRequest.EnableSsl = $false
                        }

                        if ($activeMode) {
                            $ftpRequest.UsePassive = $false
                        } else {
                            $ftpRequest.UsePassive = $true
                        }

                        $ftpRequest.ContentOffset = $remoteFileSize

                        $fileStream = New-Object System.IO.FileStream($fullLocalPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read)
                        $fileStream.Position = $remoteFileSize
                        $bufferSize = 1024
                        $buffer = New-Object byte[] $bufferSize
                        $bytesRead = $fileStream.Read($buffer, 0, $bufferSize)

                        $requestStream = $ftpRequest.GetRequestStream()
                        while ($bytesRead -gt 0) {
                            $requestStream.Write($buffer, 0, $bytesRead)
                            $bytesRead = $fileStream.Read($buffer, 0, $bufferSize)
                        }

                        $fileStream.Close()
                        $fileStream.Dispose()
                        $requestStream.Close()
                        $requestStream.Dispose()

                        $ftpResponse = $ftpRequest.GetResponse()
                        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                        $ftpResponse.Close()
                    } else {
                        Write-Verbose ((Get-ResStr 'REMOTEFILE_UPLOAD_BYPASSED') -f $localFile, $myInvocation.Mycommand)
                    }
                } else {
                    Write-Verbose ((Get-ResStr 'REMOTEFILE_IS_UPLOADED_NEW') -f $localFile, $myInvocation.Mycommand)

                    $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$fullRemotePath")
                    $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
                    $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile

                    $ftpRequest.UseBinary = $true
                    $ftpRequest.KeepAlive = $false

                    if ($protocol -eq 'ftps') {
                        $ftpRequest.EnableSsl = $true
                    } else {
                        $ftpRequest.EnableSsl = $false
                    }

                    if ($activeMode) {
                        $ftpRequest.UsePassive = $false
                    } else {
                        $ftpRequest.UsePassive = $true
                    }

                    $fileContent = [System.IO.File]::ReadAllBytes($fullLocalPath)
                    $ftpRequest.ContentLength = $fileContent.Length

                    $requestStream = $ftpRequest.GetRequestStream()
                    $requestStream.Write($fileContent, 0, $fileContent.Length)
                    $requestStream.Close()
                    $requestStream.Dispose()

                    $ftpResponse = $ftpRequest.GetResponse()
                    Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                    $ftpResponse.Close()
                }
                break

            } catch {
                $retryCount++
                if ($retryCount -ge $resumeRetries) {
                    Throw ((Get-ResStr 'MAX_RETRY_COUNT_REACHED') -f $resumeRetries, $myInvocation.Mycommand)
                } else {
                    Write-Warning ((Get-ResStr 'REMOTEFILE_ERROR_RESUMING') -f $myInvocation.Mycommand, 'Upload', $retryCount, $resumeRetries)
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }

    <#

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $iniPath = Join-Path -path $pesterFolder "pester.ini"
            $ini = Read-IniFile -path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']

            Send-FtpFile -server $server -user $user -password $secure -remoteFolder "/inbox" -localFolder $pesterFolder -localFile 'Readme.md'
            $result = Get-FtpDir -server $server -user $user -password $secure -remoteFolder "/inbox"
            Write-Host "'$result' are all files on ftp inbox folder"
        }

    #>
}
