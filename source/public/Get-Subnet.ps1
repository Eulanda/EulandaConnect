function Get-Subnet {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [int]$cidr
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$localIp
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'localIpObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $Cidr) {
                if (! $localIp) {
                    $localIp= Get-LocalIp
                }
                $localIpObj= [IPAddress]::Parse($localIp)
                $cidr =  (Get-NetIPAddress -AddressFamily IPv4 -IPAddress $localIpObj).PrefixLength
            }
            $result= ([IpAddress]([math]::pow(2, 32) -1 -bxor [math]::pow(2, (32 - $cidr))-1)).IpAddressToString
        }

        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Subnet -cidr 24
}
