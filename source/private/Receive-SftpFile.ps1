function Receive-SftpFile {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [int]$port= 22
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [securestring]$password
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFile
        ,
        [parameter(Mandatory = $false)]
        [string]$localFolder
        ,
        [parameter(Mandatory = $false)]
        [string]$localFile

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fullRemotePath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'tempFolder' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            $fullRemotePath = Join-PathUri -base $remoteFolder -path $remoteFile

            if (! $localFile) {
                $localFile = $remoteFile
            }

            if ($localFolder) {
                if ($localFolder -ne '\' ) {
                    $localFolder = "$($localFolder.TrimEnd('\'))"
                }
            }

            if ($localFile -ne $remoteFile) {
                # Create a temp folder with identical remote file name.
                # This is a limitation of the SSH implementation,
                # which expects the same filename at the destination.
                [string]$tempFolder = $(New-TempDir)
            } else {
                [string]$tempFolder = $localFolder
            }

            # Create target folder, also recursiv, if folder does not exists
            New-Item -ItemType Directory -Path $localFolder -Force | Out-Null

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
                Get-SFTPItem -SessionId $SFTPSession.SessionId -Path $fullRemotePath -destination $tempFolder -Force
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            if ($tempFolder -ne $localFolder) {
                if (Test-Path -Path (Join-Path $localFolder $localFile)) {
                    Remove-Item -Path (Join-Path $localFolder $localFile) -Force
                }

                Move-Item -Path (Join-Path $tempFolder $remoteFile) -Destination (Join-Path $localFolder $localFile)
                Remove-Item -Path $tempFolder -recurse -force -ErrorAction SilentlyContinue
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

            Receive-SftpFile -server $server -user $user -password $secure  -remoteFile 'License.md' -localFolder $env:TEMP
        }

    #>
}
