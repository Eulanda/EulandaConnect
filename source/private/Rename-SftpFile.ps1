function Rename-SftpFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
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
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

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
                port = $port
                certificate = $certificate
                user = $user
                password = $password
            }

            # Old path must exist
            if (! (Test-SftpFolder @remoteParams -remoteFolder $oldPath)) {
                Throw ((Get-ResStr 'REMOTE_FILE_OR_FOLDER_NOT_EXIST') -f $oldPath, $myInvocation.Mycommand)

            }

            # Create target folder if it not exists
            if ($newFolder) {
                if (! (Test-SftpFolder @remoteParams -remoteFolder $newFolder)) {
                    New-SftpFolder @remoteParams -remoteFolder $newFolder
                }
            }

            # Delete the destination, if the target file exists
            if ((Test-SftpFolder @remoteParams -remoteFolder $newPath)) {
                Remove-SftpFile @remoteParams -remoteFolder $newPath
            }

            $credential = New-Object System.Management.Automation.PSCredential($user, $password)
            $sessionParams = @{
                ComputerName = $server
                Credential = $credential
                Port = $port
                AcceptKey = $true
            }

            if (Test-Path $certificate) {
                $sessionParams['KeyFile'] = $certificate
            }

            $SFTPSession = New-SFTPSession @sessionParams
            try {
                Move-SFTPItem -SessionId $SFTPSession.SessionId -Path $oldPath -Destination $newPath
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }

    <# Test:

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
            Rename-SftpFile -server $server -user $user -password $secure -remoteFile 'License.md' -newFile 'License.txt'
        }

        # The 'License.md' example belongs to the ftp server test environment we recommend.
    #>
}
