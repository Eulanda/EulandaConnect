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
            <#
                # Not working in some LTE networks 2023-07-14
                $result= (Get-NetRoute -DestinationPrefix '0.0.0.0/0' `
                    -ErrorAction SilentlyContinue | `
                    Sort-Object -Property RouteMetric | `
                    Select-Object -First 1).NextHop
            #>

            $netRoutes = Get-NetRoute -DestinationPrefix '0.0.0.0/0' | Sort-Object -Property RouteMetric
            $routePrint = route print
            $matchingRoutes = @()

            # For each route in $netRoutes, check if it exists in $routePrint
            foreach ($route in $netRoutes) {
                if ($routePrint -match $route.NextHop) {
                    $matchingRoutes += $route
                }
            }

            # Sort the matching routes by their RouteMetric and select the first one
            $result = ($matchingRoutes | Sort-Object -Property RouteMetric | Select-Object -First 1).NextHop

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
