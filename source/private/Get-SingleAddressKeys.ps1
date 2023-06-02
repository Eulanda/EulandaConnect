function Get-SingleAddressKeys {
    [CmdletBinding()]
    param()

    return (Get-MappingAddressKeys).Keys
}
