function Test-PrivateIp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'endBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'privateIPRanges' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'range' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'startBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $false
        $privateIPRanges = @(
            @{
                Start = [System.Net.IPAddress]::Parse("10.0.0.0")
                End = [System.Net.IPAddress]::Parse("10.255.255.255")
            },
            @{
                Start = [System.Net.IPAddress]::Parse("172.16.0.0")
                End = [System.Net.IPAddress]::Parse("172.31.255.255")
            },
            @{
                Start = [System.Net.IPAddress]::Parse("192.168.0.0")
                End = [System.Net.IPAddress]::Parse("192.168.255.255")
            }
        )

        $ipBytes = ([System.Net.IPAddress]::Parse($ip)).GetAddressBytes()
        foreach ($range in $privateIPRanges) {
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
    # Test:  Test-PrivateIP -ip '192.168.178.2'
}
