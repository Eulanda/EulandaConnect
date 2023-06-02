function Get-NextIp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ip = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'ip', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [int]$inc = 1
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'ipBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'ipInt' -Scope 'Private' -Value ([uint32]0)
        New-Variable -Name 'ipObj' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newIp' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nextIpBytes' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nextIpInt' -Scope 'Private' -Value ([uint32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $ipObj = [IPAddress]$ip
            $ipBytes = $ipObj.GetAddressBytes()
            [System.Array]::Reverse($ipBytes)
            $ipInt = [System.BitConverter]::ToUInt32($ipBytes, 0)
            $nextIpInt = $ipInt + $inc
            $nextIpBytes = [System.BitConverter]::GetBytes($nextIpInt)
            [System.Array]::Reverse($nextIpBytes)
            if ([IntPtr]::Size -eq 4) { # x86
                $newIp = New-Object System.Net.IPAddress ([System.Array]::CreateInstance([byte], 4))
                [System.Buffer]::BlockCopy($nextIpBytes, 0, $nextIp.GetAddressBytes(), 0, 4)
            } else { # x64
                $newIp = New-Object System.Net.IPAddress -ArgumentList (,$nextIpBytes)
            }
            $result = $newIp.IPAddressToString
        }

        catch {
            $result = '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-NextIp -ip '192.168.178.20' -inc 5
}
