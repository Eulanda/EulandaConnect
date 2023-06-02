function Get-LocalIp {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'gatewayIp' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'gatewayIpObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ip' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'localIps' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'subnetMask' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subnetMaskObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $gatewayIp= Get-GatewayIp
            $gatewayIpObj= [IPAddress]::Parse($gatewayIp)

            [string[]]$localIps= (Get-NetIPAddress -AddressFamily IPV4 -PrefixOrigin DHCP,MANUAL).IpAddress

            foreach ($ip in $localIps) {
                $ipObj = [IPAddress]::Parse($ip)
                $subnetMask = Get-Subnet -localIp $ip
                $subnetMaskObj = [IPAddress]::Parse($subnetMask)
                if (($ipObj.Address -band $subnetMaskObj.Address) -eq ($gatewayIpObj.Address -band $subnetMaskObj.Address)) {
                    $result = $ip
                    break
                }
            }
        }
        catch {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LocalIp
}
