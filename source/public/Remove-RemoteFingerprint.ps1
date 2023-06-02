function Remove-RemoteFingerprint {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("sftp")]
        [string]$protocol = 'sftp'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($protocol -eq 'sftp') {
            if ([bool](Get-Module -ListAvailable -Name POSH-SSH)) {
                Import-Module -Name POSH-SSH -global
                Remove-SSHTrustedHost -HostName $server
            } else {
                Write-Error ((Get-ResStr 'POSH_NOTFOUND') -f $myInvocation.Mycommand)
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Remove-RemoteFingerprint -server 'myftp.eulanda.eu'
}
