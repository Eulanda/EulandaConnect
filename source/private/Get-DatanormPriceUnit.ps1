Function Get-DatanormPriceUnit {
    param(
        [int]$priceUnitCode
    )

    switch ($priceUnitCode) {
        0 { $priceUnit = [int]1 }
        1 { $priceUnit = [int]10 }
        2 { $priceUnit = [int]100 }
        3 { $priceUnit = [int]1000 }
        default { throw (Get-ResStr 'DATANORM_PRICEUNITCODE_ERROR') -f $priceUnitCode, $myInvocation.Mycommand }
    }

    Return $priceUnit
}
