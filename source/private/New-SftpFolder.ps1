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
    # Test:  New-SftpFolder -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}
