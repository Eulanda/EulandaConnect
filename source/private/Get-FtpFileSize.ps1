function Get-FtpFileSize {
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
        New-Variable -Name 'fileSize' -Scope 'Private' -Value ([int64]0)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int64]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)/$remoteFolder/$remoteFile")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::GetFileSize
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

        try {
            $ftpResponse = $ftpRequest.GetResponse()
            $fileSize = $ftpResponse.ContentLength
            Write-Verbose "$($myInvocation.Mycommand) status: $($ftpResponse.StatusDescription.Trim())"
            $ftpResponse.Close()
            $result = $fileSize
        } catch {
            Throw ((Get-ResStr 'REMOTE_GENERAL_ERROR') -f $myInvocation.Mycommand, $_)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
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
            $result = Get-FtpFileSize -server $server -user $user -password $secure -remoteFile 'License.md'
            Write-Host "$result size of the file in bytes"
        }

        # $result is a int32 value that indicates the file size
        # The file 'License.md' example belongs to the ftp server test environment we recommend.
    #>
}
