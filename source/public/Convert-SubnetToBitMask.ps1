function Convert-SubnetToBitmask {
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
        Test-ValidateSingle -validParams ('subnet','cidr') @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if ((! $subnet) -and (! $Cidr)) {
                $subnet = Get-Subnet # get it fron local ip
            }

            if (! $cidr) {
                $cidr = Get-Cidr -subnet $subnet
            }
            $result = ('1' * $cidr).PadRight(32, '0')
        }
        catch {
            $result= [string]"0".PadRight(32, '0')
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # test:  Convert-SubnetToBitmask -cidr 24
}
