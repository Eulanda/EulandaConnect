function Get-MaxHosts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$subnet
        ,
        [Parameter(Mandatory = $false)]
        [int]$cidr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ((! $subnet) -and (! $cidr)) {
            $subnet= Get-Subnet # get it from localIp
        }

        try {
            if (! $cidr) {
                $cidr = Get-Cidr -subnet $subnet
            }

            [int]$result = [math]::Pow(2,(32-$cidr)) - 2
        }

        catch {
            [int]$result = 0
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MaxHosts -cidr 30
}
