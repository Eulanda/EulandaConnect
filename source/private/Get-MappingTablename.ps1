function Get-MappingTablename {
    [CmdletBinding()]
    param()

    $result = @{
        'article'   = 'artikel';
        'address'   = 'adresse';
        'delivery'  = 'lieferschein';
    }

    Return $result
}
