function Get-FirstIp {
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
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $Cidr)) {
                $subnet = Get-Subnet # get it from loacalIp
            }

            if (! $networkId) {
                $networkId = Get-NetworkId -ip $ip -subnet $subnet -cidr $cidr
            }
            $result = Get-NextIp -ip $networkId
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-FirstIp -cidr 30 -ip '192.168.41.10'
}
