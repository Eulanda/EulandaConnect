function Check-WebsiteForNoIndex {
    param(
        [Parameter(Mandatory=$true)] [string] $URL,
        [System.Collections.Hashtable] $VisitedURLs = @{}
    )

    # Add current URL to visited URLs
    $VisitedURLs[$URL] = $true

    # Create a new URI object for handling relative links
    $uri = New-Object System.Uri($URL)

    Add-Type -AssemblyName System.Web
    $webClient = New-Object System.Net.WebClient

    try {
        $html = $webClient.DownloadString($URL)
        $htmlLinks = @()
        $anchorTags = [regex]::Matches($html, '<a [^>]*?>') | ForEach-Object { $_.Value }

        # Durchlaufe jeden <a ...> Tag
        foreach ($tag in $anchorTags) {
            # Finde das href-Attribut innerhalb des Tags
            $href = [regex]::Match($tag, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
            # Überprüfe das rel-Attribut auf "nofollow"
            $rel = [regex]::Match($tag, 'rel="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
            if ($rel -eq "nofollow") {
                Write-Host "Link $href has 'nofollow' attribute" -ForegroundColor Red
            }
            # Füge den Link zur Liste hinzu, wenn ein href-Attribut gefunden wurde
            if ($href -and $href -notmatch "^#") {
                $htmlLinks += $href
            }
        }

        # Check for meta refresh tags
        $metaRefresh = Select-String -InputObject $html -Pattern '<meta\s+http-equiv="refresh"\s+content="\d+;\s*url=(.*?)"' -AllMatches | ForEach-Object { $_.Matches.Groups[1].Value }
        if ($metaRefresh) {
            $htmlLinks += $metaRefresh
        }

        foreach ($link in $htmlLinks) {
            # Handle relative links
            if ($link -notmatch "^http") {
                $linkUri = New-Object System.Uri($uri, $link)
                $link = $linkUri.AbsoluteUri
            }

            # Only follow links that belong to the same domain
            $linkUri = New-Object System.Uri($link)
            if ($linkUri.Host -ne $uri.Host) {
                continue
            }

            # Skip if we have already visited this URL
            if ($VisitedURLs[$link]) {
                continue
            }

            write-host $link -ForegroundColor Blue

            try {
                $request = [System.Net.WebRequest]::Create($link)
                $response = $request.GetResponse()
            } catch {
                Write-Host "URL $Url WITH LINK $link ERROR: $_" -ForegroundColor Red
                continue
            }

            # Get the headers
            $headers = $response.Headers
            $noIndexHeader = $null

            # Check if 'X-Robots-Tag' exists
            if ($headers["X-Robots-Tag"]) {
                $noIndexHeader = $headers["X-Robots-Tag"] -contains 'noindex'
            }

            # Get the html
            $pageHtml = $webClient.DownloadString($link)

            $noIndexMetaTag = Select-String -InputObject $pageHtml -Pattern '<meta\s+name="robots"\s+content="noindex"' -AllMatches

            if ($noIndexMetaTag -or $noIndexHeader) {
                Write-Host "Page $link is excluded from indexing"  -ForegroundColor Red
            }

            # Call the function recursively for each link
            Check-WebsiteForNoIndex -URL $link -VisitedURLs $VisitedURLs
        }
    } catch {
        Write-Error $_.Exception.Message
    }
}

Check-WebsiteForNoIndex -URL "https://eulandaconnect.eulanda.eu/"
