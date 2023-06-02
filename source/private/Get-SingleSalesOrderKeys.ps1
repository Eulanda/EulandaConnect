function Get-SingleSalesOrderKeys {
    [CmdletBinding()]
    param()

    Return (Get-MappingSalesOrderKeys).Keys
}
