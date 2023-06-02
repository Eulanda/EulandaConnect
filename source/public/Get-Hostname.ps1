function Get-Hostname {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $ip) {
                $ip= Get-LocalIp
            }
            $result= [System.Net.Dns]::GetHostByAddress($ip).Hostname
        }
        catch {
            $result= ''
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Hostname
}
