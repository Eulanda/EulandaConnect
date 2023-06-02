function Get-SingleArticleKeys {
    [CmdletBinding()]
    param()

    return (Get-MappingArticleKeys).Keys
}
