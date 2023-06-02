function Get-NetworkId {
    [CmdletBinding()]
    param(
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
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'subnetObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $ip) {
                $ip= Get-LocalIp
                $subnet= Get-Subnet -localIp $ip
            }
            $ipObj= [IpAddress]$ip
            if (! $subnet) {
                $subnet = Get-Subnet -cidr $cidr
            }
            $subnetObj= [IpAddress]$subnet
            $result = ([IpAddress]($ipObj.Address -band $subnetObj.Address)).IpAddressToString
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-NetworkId -ip 192.168.178.9 -cidr 30
}
