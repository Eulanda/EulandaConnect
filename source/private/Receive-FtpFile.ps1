Function Receive-FtpFile {
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
        New-Variable -Name 'buffer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullLocalPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fullRemotePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'localFileStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'read' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'responseStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'retryCount' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$retryCount = 0

        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($remoteFolder -eq '/') {
            $fullRemotePath = "/$remoteFolder/$remoteFile"
        } else {
            $fullRemotePath = "$remoteFolder/$remoteFile"
        }

        if (! $localFile) {
            $localFile = $remoteFile
        }

        if ($localFolder) {
            if ($localFolder -ne '\' ) {
                $localFolder = "$($localFolder.TrimEnd('\'))"
            }
        }

        $fullLocalPath = (Join-Path $localFolder $localFile)

        # Create target folder, also recursiv, if folder does not exists
        New-Item -ItemType Directory -Path $localFolder -Force | Out-Null

        while ($retryCount -lt $resumeRetries) {
            try {
                $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($fullRemotePath)")
                $ftpRequest.Credentials = New-Object System.Management.Automation.PSCredential($user, $password)
                $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile

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

                $ftpResponse = $ftpRequest.GetResponse()
                $responseStream = $ftpResponse.GetResponseStream()

                $localFileStream = [System.IO.File]::Create($fullLocalPath)
                $buffer = New-Object byte[] 1024
                while (($read = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                    $localFileStream.Write($buffer, 0, $read)
                }

                $responseStream.Close()
                $responseStream.Dispose()
                $localFileStream.Close()
                $localFileStream.Dispose()
                Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
                $ftpResponse.Close()
                break

            } catch {
                $retryCount++
                Remove-Item -path $fullLocalPath -force -ErrorAction SilentlyContinue
                if ($retryCount -ge $resumeRetries) {
                    throw ((Get-ResStr 'MAX_RETRY_COUNT_REACHED') -f $resumeRetries, $myInvocation.Mycommand)
                } else {
                    Write-Warning ((Get-ResStr 'REMOTEFILE_ERROR_RESUMING') -f $myInvocation.Mycommand, 'Download', $retryCount, $resumeRetries)
                }
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Receive-FtpFile -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'newText.txt'
}
