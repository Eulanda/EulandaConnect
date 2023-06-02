function Get-SftpDir {
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
        [ValidateSet("file", "directory")]
        [string]$dirType = "file"
        ,
        [Parameter(Mandatory = $false)]
        [string]$mask = "*"
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'filename' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'sessionParams' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$result = @()

        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {
                $remoteFolder = '/'
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
                if ($dirType -eq 'file') {
                    $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -File
                } elseif ($dirType -eq 'directory') {
                    $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -Directory
                }
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            foreach ($entry in $list) {
                $filename = Split-Path $entry.FullName -Leaf
                $result += $filename
            }

            if (($mask) -and ($mask -ne '*')) {
                $result = $result | Where-Object { $_ -like $mask }
            }

            $result = $result | Sort-Object
        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }
    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpDir -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure'  -remoteFolder '/EULANDA' -verbose
}