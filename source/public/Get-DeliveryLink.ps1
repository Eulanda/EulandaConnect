function Get-DeliveryLink {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [string]$alias = 'lf'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($alias) { $alias = "$alias." }

        if ($deliveryId) {
            [string]$result = "$($alias)Id = $deliveryId"
        } else {
            [string]$result = "$($alias)KopfNummer = $deliveryNo"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryLink -deliveryId 28096 -alias lf
}
