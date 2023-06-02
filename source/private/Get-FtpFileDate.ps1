function Get-FtpFileDate {
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
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $result = [datetime]::MinValue
            $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($erver):$($port)/$remoteFolder/$remoteFile")
            $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
            $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetDateTimestamp

            $ftpResponse = $ftpRequest.GetResponse()
            $result = $ftpResponse.LastModified
            Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
            $ftpResponse.Close()

        } catch [System.Net.WebException] {
            Write-Verbose ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f ($remoteFolder/$remoteFile), $myInvocation.Mycommand)
        } catch {
            Write-Verbose ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Get-FtpFileDate -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -remoteFolder '/EULANDA' -remoteFile 'test.txt' -verbose
}