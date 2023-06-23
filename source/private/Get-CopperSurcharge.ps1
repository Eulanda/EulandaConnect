function Get-DatanormCuSurcharge {
    [CmdletBinding()]
    param (
        [int]$divisionCode
        ,
        [double]$cuIncluded
        ,
        [double]$cuWeight
        ,
        [double]$cuDel = 879 # last official cuDel (Copper-DEL Notation) price 02/2022
    )

    <#
        .SYNOPSIS
        Calculates the copper surcharge for a product based on various parameters
        including the copper weight, the division code, and the included and actual copper prices.

        .DESCRIPTION
        The `Get-DatanormCuSurcharge` function calculates the copper surcharge that applies to a product
        in a Datanorm file. The calculation is based on the weight of copper in the product,
        the division code that indicates how the weight is measured (per unit, per 100 units, or per 1000 units),
        and the difference between the included and actual copper prices.

        The copper weight must be specified in kilograms. The division code is an integer value where 0 indicates
        no copper processing, 1 indicates that the weight is per 100 units,
        and 2 indicates that the weight is per 1000 units.

        The included copper price and actual copper price (known as `cuDel`) should be specified per 100 kg.
        The function returns the calculated copper surcharge. If the surcharge would be
        negative (i.e., the actual price is less than the included price), the function returns 0.

        .PARAMETER divisionCode
        The division code for the copper weight. Valid values are 0 (no copper processing),
        1 (weight is per 100 units), and 2 (weight is per 1000 units).

        .PARAMETER cuIncluded
        The copper price already included in the base product price, specified per 100 kg.

        .PARAMETER cuWeight
        The weight of copper in the product, specified in kilograms but depends also on the devisionCode

        .PARAMETER cuDel
        The actual copper price, specified per 100 kg. The default value is 879.

        .EXAMPLE
        Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 879 -cuIncluded 150

        This example calculates the copper surcharge for a product with a copper weight of 2.5 kg,
        a division code of 1 (indicating that the weight is per 100 units),
        and an included copper price of 150 per 100 kg. The actual copper price (cuDel)
        is assumed to be the default value of 879 per 100 kg.

        The result is in this case: 0,18225 EUR
    #>

    $copperSurcharge = 0

    $weightPerUnit = Get-DatanormCuWeight -cuWeight $cuWeight -divisionCode $divisionCode

    # Calculate the copper surcharge
    if ($weightPerUnit -gt 0) {
        $copperSurcharge = $weightPerUnit * ($cuDel - $cuIncluded) / 100
        if ($copperSurcharge -lt 0.0) {
            $copperSurcharge = [double]0.0
        }
    }

    return $copperSurcharge

    # Test: Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 879 -cuIncluded 150
}
