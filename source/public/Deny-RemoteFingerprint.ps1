function Deny-RemoteFingerprint {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'cachedFingerprint' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'remoteFingerprint' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($protocol -eq 'sftp') {
            if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
                Import-Module -Name POSH-SSH -global
                $trustedInfo = Get-SSHTrustedHost -HostName $server
                if ($trustedInfo) {
                    $cachedFingerprint = [string]($trustedInfo).Fingerprint
                }
                try {
                    $serverInfo = Get-SSHHostKey -ComputerName $server -Port $port
                    if ($serverInfo) {
                        $remoteFingerprint = [string]($serverInfo).Fingerprint
                        if (($null -ne $cachedFingerprint -and $cachedFingerprint -ne "") -and $cachedFingerprint -ne $remoteFingerprint) {
                            $result = $true
                        }
                    }
                } catch {
                }
            } else {
                Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Deny-RemoteFingerprint -server '192.168.42.1'
}
