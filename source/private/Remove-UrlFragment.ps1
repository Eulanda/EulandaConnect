function Remove-UrlFragment {
    [CmdletBinding()]
    param(
        [string]$url
    )

    $result = $url
    # Remove the real hashtag fragment, if any, and append a slash in this case
    if ($url -match "#") {
        # Search for the anchor from behind
        $anchorIndex = $url.LastIndexOf("#")

        if ($anchorIndex -ge 0) {
            $startIndex = $anchorIndex - 1

            # When you have found a special character, the search continues to the left
            while ($startIndex -ge 0 -and $url[$anchorIndex-1] -eq '&' ) {
                $anchorIndex = $url.LastIndexOf('#',$startIndex)
            }

            if ($anchorIndex -ge 0) {
                $result = $url.Substring(0, $anchorIndex)
                if ($result) {
                    $result = $result.TrimEnd('/') + '/'
                }
            }
        }
    }

    Return $result
    # Test: Remove-UrlFragment -url 'entwu#rf-die-b&#xE4;nder-3'
}

