function Get-Cidr {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [string]$ip
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'subnetBitString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'subnetBytes' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! $subnet) {
                if (! $ip) {
                    $ip= Get-LocalIp
                }
                $ipObj= [IPAddress]::Parse($ip)
                $result =  (Get-NetIPAddress -AddressFamily IPv4 -IPAddress $ipObj -ErrorAction SilentlyContinue).PrefixLength
            } else {
                $subnetBytes = $subnet.Split('.') | ForEach-Object { [byte] $_ }
                $subnetBitString = [Convert]::ToString($subnetBytes[0], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[1], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[2], 2).PadLeft(8, '0') + `
                                      [Convert]::ToString($subnetBytes[3], 2).PadLeft(8, '0')
                $result = $subnetBitString.Replace('0','').Length
            }
        }
        catch {
            $result= 0
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Cidr -subnet 255.255.255.0
}
