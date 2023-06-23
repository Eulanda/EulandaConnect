function Get-DatanormCuWeight {
    [CmdletBinding()]
    param (
        [int]$divisionCode
        ,
        [double]$cuWeight
    )

    <#
        .SYNOPSIS
        Calculates the copper weight per unit for a given item based on the supplied division code and copper weight.

        .DESCRIPTION
        The `Get-DatanormCuWeight` function calculates the copper weight per unit for a specific
        item based on the supplied division code and the total copper weight of the item.
        The division code determines how the total copper weight is divided:

        - Division code 0: The item doesn't involve any copper processing, so the copper weight per unit is 0.
        - Division code 1: The copper weight provided is for 100 units, so the total copper weight is
          divided by 100 to get the copper weight per unit.
        - Division code 2: The copper weight provided is for 1000 units, so the total copper weight is
          divided by 1000 to get the copper weight per unit.

        .PARAMETER divisionCode
        The division code indicating how the total copper weight is to be divided to get the copper
        weight per unit. Accepted values are 0, 1, and 2.

        .PARAMETER cuWeight
        The total copper weight for the item. This will be divided according to the
        division code to calculate the copper weight per unit.

        .EXAMPLE
        Get-DatanormCuWeight -cuWeight 2.5 -divisionCode 1
        This command calculates the copper weight per unit for an item with a total copper
        weight of 2.5kg, where this weight is for 100 units.

        Result is: 0,025 kg per unit copper

        .INPUTS
        System.Int32, System.Double

        .OUTPUTS
        System.Double

        .NOTES
        The division code must be one of the following values:
        0 - The item does not involve any copper processing.
        1 - The copper weight provided is for 100 units.
        2 - The copper weight provided is for 1000 units.
        Any other value will cause an error.
    #>


    # Calculate the weight per unit depending on the Merker value
    switch ($divisionCode) {
        0 { $weightPerUnit = 0 } # no copper processing
        1 { $weightPerUnit = $cuWeight / 100 } # weight is per 100 units
        2 { $weightPerUnit = $cuWeight / 1000 } # weight is per 1000 units
        default { throw (Get-ResStr 'DATANORM_DEVISIONCODE_ERROR') -f $divisionCode, $myInvocation.Mycommand }
    }

    return $weightPerUnit

    # Test: Get-DatanormCuWeight -cuWeight 2.5 -divisionCode 1
}
