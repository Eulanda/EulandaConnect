function Test-ReservedIp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'endBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'range' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'reservedIPRanges' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'startBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $false
        $reservedIPRanges = @(
            # Current network (only valid as source address)
            @{
                Start = [System.Net.IPAddress]::Parse("0.0.0.0")
                End = [System.Net.IPAddress]::Parse("0.255.255.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("10.0.0.0")
                End = [System.Net.IPAddress]::Parse("10.255.255.255")
            },
            # Shared Address Space for communications between a service provider and its subscribers
            @{
                Start = [System.Net.IPAddress]::Parse("100.64.0.0")
                End = [System.Net.IPAddress]::Parse("100.127.255.255")
            },
            # Loopback
            @{
                Start = [System.Net.IPAddress]::Parse("127.0.0.0")
                End = [System.Net.IPAddress]::Parse("127.255.255.255")
            },
            # Link local
            @{
                Start = [System.Net.IPAddress]::Parse("169.254.0.0")
                End = [System.Net.IPAddress]::Parse("169.254.255.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("172.16.0.0")
                End = [System.Net.IPAddress]::Parse("172.31.255.255")
            },
            # IETF protocol assignments
            @{
                Start = [System.Net.IPAddress]::Parse("192.0.0.0")
                End = [System.Net.IPAddress]::Parse("192.0.0.255")
            },
            # TEST-NET-1, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("192.0.2.0")
                End = [System.Net.IPAddress]::Parse("192.0.2.255")
            },
            # IPv6 to IPv4 relay
            @{
                Start = [System.Net.IPAddress]::Parse("192.88.99.0")
                End = [System.Net.IPAddress]::Parse("192.88.99.255")
            },
            # Private network
            @{
                Start = [System.Net.IPAddress]::Parse("192.168.0.0")
                End = [System.Net.IPAddress]::Parse("192.168.255.255")
            },
            # Network benchmark tests
            @{
                Start = [System.Net.IPAddress]::Parse("198.18.0.0")
                End = [System.Net.IPAddress]::Parse("198.19.255.255")
            },
            # TEST-NET-2, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("198.51.100.0")
                End = [System.Net.IPAddress]::Parse("198.51.100.255")
            },
            # TEST-NET-3, for documentation and example code
            @{
                Start = [System.Net.IPAddress]::Parse("203.0.113.0")
                End = [System.Net.IPAddress]::Parse("203.0.113.255")
            },
            # Multicast
            @{
                Start = [System.Net.IPAddress]::Parse("224.0.0.0")
                End = [System.Net.IPAddress]::Parse("239.255.255.255")
            }
        )

        $ipBytes = ([System.Net.IPAddress]::Parse($ip)).GetAddressBytes()
        foreach ($range in $reservedIPRanges) {
            $startBytes = $range.Start.GetAddressBytes()
            $endBytes = $range.End.GetAddressBytes()

            if (($ipBytes[0] -ge $startBytes[0] -and $ipBytes[0] -le $endBytes[0]) -and
                ($ipBytes[1] -ge $startBytes[1] -and $ipBytes[1] -le $endBytes[1]) -and
                ($ipBytes[2] -ge $startBytes[2] -and $ipBytes[2] -le $endBytes[2]) -and
                ($ipBytes[3] -ge $startBytes[3] -and $ipBytes[3] -le $endBytes[3])) {
                $result = $true
                break
            }
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ReservedIP -ip '127.0.0.0'
}
