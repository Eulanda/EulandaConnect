function Get-FtpFileAge {
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
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileAge' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)/$remoteFolder/$remoteFile")
            $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
            $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp

            $ftpResponse = $ftpRequest.GetResponse()
            $fileAge = [DateTime]::Now - $ftpResponse.LastModified
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)

            $result = [int]$fileAge.TotalSeconds
        } catch [System.Net.WebException] {
            Write-Verbose ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f ($remoteFolder/$remoteFile), $myInvocation.Mycommand)
        } catch {
            Write-Verbose ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        } finally {
            if ($null -ne $ftpResponse) {
                try {
                    $ftpResponse.Close()
                } catch {
                    Write-Warning ((Get-ResStr 'REMOTE_COULD_NOT_CLOSE') -f $myInvocation.Mycommand, $_)
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-FtpFileAge -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFfolder '/EULANDA' -remoteFile 'test.txt' -verbose
}
