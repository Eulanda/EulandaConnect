function Get-SftpNextFilename {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = 22
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
        [string]$mask
        ,
        [parameter(Mandatory = $false)]
        [string]$remoteFolder

    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'credential' -Scope 'Private' -Value ($null)
        New-Variable -Name 'filteredList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'list' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'oldestFile' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'SFTPSession' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sortedList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
            Import-Module -Name POSH-SSH -global

            if ($remoteFolder) {
                [string]$remoteFolder = "$($remoteFolder.TrimEnd('/'))"
                if (! $remoteFolder) { $remoteFolder = '/'}
            } else {$remoteFolder = '/'}

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
                $list = Get-SFTPChildItem -SessionId $SFTPSession.SessionId -Path $remoteFolder -File
            }
            finally {
                Remove-SFTPSession -SFTPSession $SFTPSession | Out-Null
            }

            if ($mask) {
                $filteredList = $list | Where-Object { $_.Name -like "$mask" }
            } else {
                $filteredList = $list
            }

            if ($filteredList) {
                $sortedList = $filteredList | Sort-Object { $_.LastWriteTime }
                $oldestFile = $sortedList[0].Name
                [string]$result = Split-Path $oldestFile -Leaf
            }

        } else {
            Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SftpNextFilename -server 'myftp.eulanda.eu' -user 'johndoe' -password 'secure' -mask '*.xml' -remoteFolder '/EULANDA'
}
