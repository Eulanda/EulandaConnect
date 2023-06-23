Function Get-DatanormPricePerUnit {
    param(
        [double]$price
        ,
        [int]$priceUnitCode
    )

    switch ($priceUnitCode) {
        0 { $pricePerUnit = $price }
        1 { $pricePerUnit = $price / 10 }
        2 { $pricePerUnit = $price / 100 }
        3 { $pricePerUnit = $price / 1000 }
        default { throw (Get-ResStr 'DATANORM_PRICEUNITCODE_ERROR') -f $priceUnitCode, $myInvocation.Mycommand }
    }

    Return $pricePerUnit
}