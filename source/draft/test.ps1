# URL
# Test pattern
#   '#entwurf-die' -> ''
#   'entwurf-die' -> 'entwurf-die'
#   'entwurf-die#' -> 'entwurf-die/'
#   'entwurf-die-b&#xE4;nder-3' ->  'entwurf-die-b&#xE4;nder-3'
#   'entwurf-die-b&#xE4;nd#er-3' ->  'entwurf-die-b&#xE4;nd/'
#   'entwu#rf-die-b&#xE4;nder-3' ->  'entwu/'
#   'entwurf/' ->  'entwurf/'
#   '' ->  ''
#   '/' ->  '/'

$url = 'entwurf-die#'
# Search for the anchor from behind
$anchorIndex = $url.LastIndexOf("#")

if ($anchorIndex -ge 0) {

    $startIndex = $anchorIndex - 1

    while ($startIndex -ge 0 -and $url[$anchorIndex-1] -eq '&' ) {
        $anchorIndex = $url.LastIndexOf('#',$startIndex)
    }

    if ($anchorIndex -ge 0) {
        $url = $url.Substring(0, $anchorIndex)
        if ($url) {
            $url = $url.TrimEnd('/') + '/'
        }
    }
}

# Gib die modifizierte URL aus
$url