function Test-WebsiteForNoIndex1 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$url,
        [string]$parent,
        [System.Collections.Hashtable]$visitedUrls
    )
    # ******************************
    # Checking fast for broken links
    # ******************************

    # Normalize Slash and remove hashtag fragment if exists
    $url = ($url -split "#" | Select-Object -First 1).TrimEnd('/') + '/'

    # If we have already visited this url, no need to process again
    if ($visitedUrls[$url]) {
        return
    }

    # Add current URL to visited URLs
    $visitedUrls[$url] = $true

    Write-Host "Processing: $url" -ForegroundColor Green
    $global:verde = $global:verde + 1

    # Create a new URI object for handling relative links
    $uri = New-Object System.Uri($url)

    Add-Type -AssemblyName System.Web
    $webClient = New-Object System.Net.WebClient

    try {
        $html = $webClient.DownloadString($url)
        $htmlLinks = @()
        $anchorTags = [regex]::Matches($html, '<a [^>]*?>') | ForEach-Object { $_.Value }

        # Pass through each <a ...> tag
        foreach ($tag in $anchorTags) {
            # Find the href attribute inside the tag
            $href = [regex]::Match($tag, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }

            # Check the rel attribute for "nofollow"
            $rel = [regex]::Match($tag, 'rel="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
            if ($rel -eq "nofollow") {
                Write-Host "Link $href has 'nofollow' attribute" -ForegroundColor Yellow
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

            try {
                # Handle relative links
                if ($link -notmatch "^http") {
                    $linkUri = New-Object System.Uri($uri, $link)
                    $link = $linkUri.AbsoluteUri
                }
            }
            catch {
                Write-Host "(1) Page: $url Link: $link Message: $($_.Exception.Message)" -ForegroundColor Red
                Continue
            }

            try {
                # Only follow links that belong to the same domain
                $linkUri = New-Object System.Uri($link)
                if ($linkUri.Host -ne $uri.Host) {
                    continue
                }

            }
            catch {
                Write-Host "(2) Page: $url Link: $link Message: $($_.Exception.Message)" -ForegroundColor Red
                Continue
            }

            # Skip if we have already visited this url
            if ($visitedUrls[$link]) {
                # Write-Host "Skipping: $link" -ForegroundColor Blue
                continue
            }

            Test-WebsiteForNoIndex1 -url $link -parent $url -visitedUrls $visitedUrls
        }
    } catch {
        Write-Host "(3) Page: $parent Link: $url Message: $($_.Exception.Message)" -ForegroundColor Red
    }
}



function Test-WebsiteForNoIndex2 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$url
        ,
        [System.Collections.Hashtable]$visitedUrls = @{}
    )
    # ******************************
    # Checking for noIndex and broken links
    # ******************************


    # Add current URL to visited URLs
    $visitedUrls[$url] = $true

    # Create a new URI object for handling relative links
    $uri = New-Object System.Uri($url)

    Add-Type -AssemblyName System.Web
    $webClient = New-Object System.Net.WebClient

    try {
        $html = $webClient.DownloadString($url)
        $htmlLinks = @()
        $anchorTags = [regex]::Matches($html, '<a [^>]*?>') | ForEach-Object { $_.Value }

        # Pass through each <a ...> tag
        foreach ($tag in $anchorTags) {
            # Find the href attribute inside the tag
            $href = [regex]::Match($tag, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
            # Check the rel attribute for "nofollow"
            $rel = [regex]::Match($tag, 'rel="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
            if ($rel -eq "nofollow") {
                Write-Host "Link $href has 'nofollow' attribute" -ForegroundColor Yellow
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

        Write-Host $url -ForegroundColor Green
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

            # write-host $link -ForegroundColor Blue

            try {
                $request = [System.Net.WebRequest]::Create($link)
                $response = $request.GetResponse()
            } catch {
                Write-Host "URL $url WITH LINK $link ERROR: $_" -ForegroundColor Red
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
                Write-Host "Page $link is excluded from indexing"  -ForegroundColor Yellow
            }

            # Call the function recursively for each link
            # Test-WebsiteForNoIndex -url $link -visitedUrls $visitedUrls
            if (-not $visitedUrls[$link]) {
                $visitedUrls = Test-WebsiteForNoIndex2 -url $link -visitedUrls $visitedUrls
            }
        }
    } catch {
        Write-Error $_.Exception.Message
    }

    # End of function
    return $visitedUrls
}


$visitedUrls = @{}
Test-WebsiteForNoIndex1 -url "https://eulandaconnect.eulanda.eu/" -visitedUrls $visitedUrls


# $i = Test-WebsiteForNoIndex2 -url "https://eulandaconnect.eulanda.eu/"

