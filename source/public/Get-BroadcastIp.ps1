function Get-BroadcastIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$networkId
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
        ,
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'maxHosts' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $cidr)) {
                $subnet = Get-Subnet # get it from localIp
            }

            if (! $networkId) {
                $networkId = Get-NetworkId -ip $ip -subnet $subnet -cidr $cidr
            }
            $maxHosts = Get-MaxHosts -subnet $subnet -cidr $cidr
            $result = Get-NextIp -ip $networkId -inc ($maxHosts + 1)
        }
        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-BroadcastIp -networkId 192.168.192.8 -cidr 30
}
