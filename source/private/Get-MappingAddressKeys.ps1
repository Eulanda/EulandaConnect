function Get-MappingAddressKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'addressId'   = 'Id';
        'addressMatch'= 'Match';
        'addressUid'  = 'Uid';
    }

    Return $result
}
