Function Get-DatanormPricePerUnit {
    param(
        [double]$price
        ,
        [int]$priceUnitCode
    )

    $priceUnit = Get-DatanormPriceUnit -priceUnitCode $priceUnitCode
    if ($priceUnit -gt 1) {
        $result = $price / $priceUnit
    } else {
        $result = $price
    }

    Return $result
}