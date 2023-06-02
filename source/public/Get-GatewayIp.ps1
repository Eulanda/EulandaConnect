function Get-GatewayIp {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $result= (Get-NetRoute -DestinationPrefix '0.0.0.0/0' `
                -ErrorAction SilentlyContinue | `
                Sort-Object -Property RouteMetric | `
                Select-Object -First 1).NextHop
        }
        catch {
            $result='0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-GatewayIp
}
