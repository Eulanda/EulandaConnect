function Rename-FtpFile {
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
        [string]$remoteFolder = '/'
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$newFile
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ftpRequest' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ftpResponse' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($remoteFolder) {
            [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
            if (! $remoteFolder) { $remoteFolder = '/'}
        } else {
            $remoteFolder = '/'
        }

        if ($newFolder) {
            [string]$newFolder = "$($newFolder.TrimEnd('/'))"
            if (! $newFolder) { $newFolder = '/'}
        }

        if ($remoteFolder -eq '/') {
            $oldPath = "$($remoteFolder)$remoteFile"
        } else {
            $oldPath = "$remoteFolder/$remoteFile"
        }

        if ($newFolder -and $newFile) {
            if ($newFolder -eq '/') {
                $newPath = "$($newFolder)$newFile"
            } else {
                $newPath = "$newFolder/$newFile"
            }
        } elseif ($newFolder) {
            if ($newFolder -eq '/') {
                $newPath = "$($newFolder)$remoteFile"
            } else {
                $newPath = "$newFolder/$remoteFile"
            }
        } else {
            if ($remoteFolder -eq '/') {
                $newPath = "$($remoteFolder)$newFile"
            } else {
                $newPath = "$remoteFolder/$newFile"
            }
            $newFolder = $remoteFolder
        }

        $remoteParams = @{
            server = $server
            protocol = $protocol
            port = $port
            activeMode = $activeMode
            user = $user
            password = $password
        }

        # Old path must exist
        if (! (Test-FtpFolder @remoteParams -remoteFolder $oldPath)) {
            Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $oldPath, $myInvocation.Mycommand)
        }



        # Create target folder if it not exists
        if ($newFolder) {
            if (! (Test-FtpFolder @remoteParams -remoteFolder $newFolder)) {
                New-FtpFolder @remoteParams -remoteFolder $newFolder
            }
        }

        # Delete the destination, if the target file exists
        if ((Test-FtpFolder @remoteParams -remoteFolder $newPath)) {
            Remove-FtpFile @remoteParams -remoteFolder $newPath
        }


        $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$($server):$($port)$($oldPath)")
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($user, $password)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::Rename
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

        $ftpRequest.RenameTo = $newPath
        $ftpResponse = $ftpRequest.GetResponse()
        Write-Verbose ((Get-ResStr 'REMOTE_RESPONSE_STATUS') -f $ftpResponse.StatusDescription.Trim(), $myInvocation.Mycommand)
        $ftpResponse.Close()
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
            Rename-FtpFile -server $server -user $user -password $secure -remoteFile 'License.md' -newFile 'License.txt'
        }

        # The 'License.md' example belongs to the ftp server test environment we recommend.
    #>
}
