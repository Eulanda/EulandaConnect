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

        # RRemove hashtag fragment if present, but ignore the hashtag &# for Unicode
        $url = Remove-UrlFragment -url $url

        # If we have already visited this url, no need to process again
        if ($visitedUrls[$url]) {
            continue
        }

        # Add current URL to visited URLs
        $visitedUrls[$url] = $true

        if ($show) { Write-Host "Processing: $url" -ForegroundColor Green }

        # Create a new URI object for handling relative links
        $uri = New-Object System.Uri($url)

        # At start parent is empty, so we use the base URL at the beginning
        $parentUrl = if ($parent) { $parent } else { $url }

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
                $noIndexMetaTag = Select-String -InputObject $html -Pattern '<meta\s+name="robots"\s+content="noindex"' -AllMatches
                if ($noIndexMetaTag -or $noIndexHeader) {
                    if ($show) { Write-Host "Page $url is excluded from indexing"  -ForegroundColor Yellow }
                    $noIndex[$url] = $true
                }
            }

            # Get all links in document
            $htmlLinks = @()
            $anchorTags = [regex]::Matches($html, '<a [^>]*?>') | ForEach-Object { $_.Value }

            # Pass through each <a ...> tag
            foreach ($tag in $anchorTags) {
                # Check if the href attribute is missing
                if ($tag -notmatch 'href=') {
                    # It's not necessarily a bug, but we only need tags with href.
                    continue
                }


                # Find the href attribute inside the tag but at first it tries with quotes
                $href = [regex]::Match($tag, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
                if (!$href) {
                    # Find href if is not in quotes like <a href=/news/ class="link white">
                    $href = $tag -replace '^<a href=([^ >]+).*$', '$1'
                }
                $href = $href.trim('"')

                # Add the link to the list if an href attribute was found but
                # if it doesn't contain "javascript:" and also not contains ? or =
                if ($href `
                    -and $href -notmatch "^#" `
                    -and $href -notmatch "^javascript:" `
                    -and $href -notmatch "\?" `
                    -and $href -notmatch "=" `
                    -and $href -notmatch "^ftp:" `
                    -and $href -notmatch "^tel:" `
                    -and $href -notmatch "^phone:") {
                    $htmlLinks += $href

                    # Check the rel attribute for "nofollow" but at first it tries with quotes
                    $rel = [regex]::Match($tag, 'rel="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
                    if (!$rel) {
                        # Find rel if is not in quotes like <a href=/news/ class="link white" rel=nofollow>
                        $rel = $tag -replace '.*rel\s*=\s*([^ >]+).*', '$1'
                    }
                    $rel = $rel.trim('"')


                    if ($rel -eq "nofollow") {
                        if ($show) { Write-Host "Link $href has 'nofollow' attribute" -ForegroundColor Yellow }
                        $noFollow["$parent@$href"] = $true
                    }
                }
            }

            # Check for meta refresh tags
            $metaRefresh = Select-String -InputObject $html -Pattern '<meta\s+http-equiv="refresh"\s+content="\d+;\s*url=(.*?)"' -AllMatches | ForEach-Object { $_.Matches.Groups[1].Value }
            if ($metaRefresh) {
                $htmlLinks += $metaRefresh
            }

            foreach ($link in $htmlLinks) {

                # Ignore mailto: links
                if ($link -match "^mailto:") {
                    continue
                }

                # Handle relative links
                if ($link -notmatch "^http" -and $link -notmatch "^mailto:") {
                    if ($link -match "^/") {
                        # Case 1: Link is relative to the base URL like '/test'
                        $linkUri = New-Object System.Uri($uri, $link)
                    }
                    elseif ($link -match "^(\.\./)+") {
                        # Case 2: Link is relative to the current path like '../../test'
                        $parentUri = New-Object System.Uri($url)
                        $count = ($link | Select-String -Pattern "\.\./" -AllMatches).Matches.Count
                        $segments = $parentUri.Segments[0..($parentUri.Segments.Length - $count - 1)]
                        $parentPath = $parentUri.Scheme + "://" + $parentUri.Host + [System.String]::Join('', $segments)
                        $relativeLink = $link -replace "(\.\./)+", ""
                        $linkUri = New-Object System.Uri($parentPath + $relativeLink)
                    }
                    else {
                        # Case 3: Link is in the same directory as the current path like 'test.html' or like './test.html'
                        $parentPath = $parentUrl -replace "(.*://.*/).*$", '$1'  # Use $parentUrl instead of $parent
                        $linkUri = New-Object System.Uri($parentPath + $link)
                    }
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
                if ($_.Exception.Message -notmatch "404") {
                    Write-Host "Broken: $parentLink -> $url $($_.Exception.Message)" -ForegroundColor Red
                } else {
                    Write-Host "Broken: $parentLink -> $url" -ForegroundColor Red
                }
            }
            if ($_.Exception.Message -notmatch "404") {
                $broken["$parent -> $url $($_.Exception.Message)"] = $true
            } else {
                $broken["$parent -> $url"] = $true
            }
        }
    }

    $result = New-Object PSObject -Property @{
        VisitedUrls = $visitedUrls.Keys
        NoIndex = $noIndex.Keys
        NoFollow = $noFollow.Keys
        Broken = $broken.Keys
    }

    if ($show) {
        Write-Host "SUMMARY of the website analysis"
        Write-Host "==============================="
        Write-Host "Pages found: $($result.VisitedUrls.count)"

        Write-Host "NoIndex tag found: $($result.noIndex.count)"
        if ($result.noIndex.count -gt 0) { $result.noIndex | ForEach-Object { Write-Host "NoIndex: $_" } }

        Write-Host "NoFollow tag found: $($result.noFollow.count)"
        if ($result.noFollow.count -gt 0) { $result.noFollow | ForEach-Object { Write-Host "NoFollow: $_" } }

        Write-Host "Broken links found: $($result.Broken.count)"
        if ($result.broken.count -gt 0) { $result.broken | ForEach-Object { Write-Host "Broken: $_" } }
    }

    Return $result

    # Test: $myResult = Test-Website -url "https://eulandaconnect.eulanda.eu/" -show

    # Test-Website -url "https://eulandaconnect.eulanda.eu/" -show | Out-Null
    # Test-Website -url "http://www.esgedv.com/" -show | Out-Null
    # Test-Website -url "https://gohugo.io/" -show | Out-Null
    # Test-Website -url "https://www.eulanda.eu/" -show | Out-Null
    # Test-Website -url "https://www.we-elektronik.com" -show | Out-Null
    # Test-Website -url "https://www.bargellinibevande.it/" -show | Out-Null
    # Test-Website -url "https://www.wizz-software.nl/" -show | Out-Null
}
