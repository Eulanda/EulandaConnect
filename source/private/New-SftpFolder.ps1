Function New-SftpFolder {
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
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'folder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'folders' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

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
                $folders = $remoteFolder -split '/'
                [string]$path = ""
                foreach ($folder in $folders) {
                    if ($folder) {
                        $path = $path + '/' + $folder
                        if (-not(Test-SftpFolder -server $server -port $port -user $user -password $password -remoteFolder $path  )) {
                            New-SFTPItem -SessionId $SFTPSession.SessionId -Path $path -ItemType Directory | Out-Null
                        }
                    }
                }
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

            $folderName = -join ((65..90) | Get-Random -Count 10 | % {[char]$_})
            New-SftpFolder -server $server -user $user -password $secure -remoteFolder "/$folderName"
            $result = Get-SftpDir -server $server -user $user -password $secure -dirType directory
            Write-Host "'$result' are all remote folders including the new '$folderName'"
        }
    #>
}
