function Test-Website {
    param(
        [Parameter(Mandatory=$true)]
        [string]$url
        ,
        [switch]$show
    )

    # Initialize hashtables
    $visitedUrls = @{}
    $noIndex = @{}
    $noFollow = @{}
    $broken = @{}


    # Queue for URLs to be visited
    $queue = New-Object System.Collections.Queue
    $queue.Enqueue(@{Url=$url; Parent=$null})

    # While there are still URLs to visit
    while($queue.Count -gt 0) {
        $item = $queue.Dequeue()
        $url = $item.Url
        $parent = $item.Parent

        # Normalize Slash and remove hashtag fragment if exists
        $url = ($url -split "#" | Select-Object -First 1).TrimEnd('/') + '/'

        # If we have already visited this url, no need to process again
        if ($visitedUrls[$url]) {
            continue
        }

        # Add current URL to visited URLs
        $visitedUrls[$url] = $true

        if ($show) { Write-Host "Processing: $url" -ForegroundColor Green }

        # Create a new URI object for handling relative links
        $uri = New-Object System.Uri($url)

        try {
            $request = [System.Net.WebRequest]::Create($url)
            $response = $request.GetResponse()
            $headers = $response.Headers

            # Load html page
            $stream = $response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($stream)
            $html = $reader.ReadToEnd()

            # Check robot header or html meta tag
            if ($headers["X-Robots-Tag"]) {
                $noIndexHeader = $headers["X-Robots-Tag"] -contains 'noindex'
            }
            $noIndexMetaTag = Select-String -InputObject $html -Pattern '<meta\s+name="robots"\s+content="noindex"' -AllMatches
            if ($noIndexMetaTag -or $noIndexHeader) {
                if ($show) { Write-Host "Page $url is excluded from indexing"  -ForegroundColor Yellow }
                $noIndex[$url] = $true
            }

            # Get all links in document
            $htmlLinks = @()
            $anchorTags = [regex]::Matches($html, '<a [^>]*?>') | ForEach-Object { $_.Value }

            # Pass through each <a ...> tag
            foreach ($tag in $anchorTags) {
                # Find the href attribute inside the tag
                $href = [regex]::Match($tag, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }

                # Check the rel attribute for "nofollow"
                $rel = [regex]::Match($tag, 'rel="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
                if ($rel -eq "nofollow") {
                    if ($show) { Write-Host "Link $href has 'nofollow' attribute" -ForegroundColor Yellow }
                    $noFollow["$parent@$href"] = $true
                }

                # Add the link to the list if an href attribute was found
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

                # Skip if we have already visited this url
                if ($visitedUrls[$link]) {
                    continue
                }

                # Add the link to the queue to be visited
                if (-not $visitedUrls.ContainsKey($link)) {
                    $queue.Enqueue(@{Url=$link; Parent=$url})
                }
            }

        } catch {
            if ($show) {
                $parentLink = if ($parent) { $parent } else { "Start-URL" }
                Write-Host "Broken: $parentLink -> $url" -ForegroundColor Red
            }
            $broken["$parent -> $url"] = $true
        }
    }

    $result = New-Object PSObject -Property @{
        VisitedUrls = $visitedUrls.Keys
        NoIndex = $noIndex.Keys
        NoFollow = $noFollow.Keys
        Broken = $broken.Keys
    }

    Return $result
}


$r = Test-Website -url "https://eulandaconnect.eulanda.eu/" -show

Write-Host "Pages: $($r.VisitedUrls.count)"

Write-Host "NoIndex: $($r.noIndex.count)"
if ($r.noIndex.count -gt 0) { $r.noIndex | ForEach-Object { Write-Host "NoIndex: $_" } }

Write-Host "NoFollow: $($r.noFollow.count)"
if ($r.noFollow.count -gt 0) { $r.noFollow | ForEach-Object { Write-Host "NoFollow: $_" } }

Write-Host "Broken Links: $($r.Broken.count)"
if ($r.broken.count -gt 0) { $r.broken | ForEach-Object { Write-Host "Broken: $_" } }


Write-Host "ready"
