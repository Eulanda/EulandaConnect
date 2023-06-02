function Get-MappingSalesOrderKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'salesOrderId'   = 'Id';
        'salesOrderNo'   = 'KopfNummer';
        'customerOrderNo'  = 'Bestellnummer';
    }

    Return $result
}
