function Get-MappingArticleKeys {
    [CmdletBinding()]
    param()

    $result = @{
        'articleId'   = 'Id';
        'articleNo'   = 'ArtNummer';
        'articleUid'  = 'Uid';
        'Barcode'  = 'Barcode';
    }

    Return $result
}
