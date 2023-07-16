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
            <#
            if (($null -eq $subnet) -and ($null -eq $cidr)) {
                $subnet = Get-Subnet # get it from local ip
            }
#>
            if ($null -eq $cidr) {
                $cidr = Get-Cidr -subnet $subnet
            }

            if ($cidr -lt 0 -or $cidr -gt 32) {
                throw "CIDR value ($cidr) is out of the valid range (0-32)"
            }

            $result = ('1' * $cidr).PadRight(32, '0')
        }
        catch {
            throw $_  # Propagate the error
        }
    }


    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # test:  Convert-SubnetToBitmask -cidr 24
}
