---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-Website.md
schema: 2.0.0
---

# Test-Website

## SYNOPSIS
The `Test-Website` function is a PowerShell script for comprehensive website exploration and analysis, designed to operate non-recursively for memory efficiency.

## SYNTAX

```
Test-Website [-url] <String> [-show] [<CommonParameters>]
```

## DESCRIPTION
The `Test-Website` function is designed to provide in-depth analysis of a website, including link validity, page indexing status, and `noFollow` link identification. The function uses a queue-based approach for memory efficiency, avoiding recursion while processing URLs. It checks for broken links, provides a comprehensive list of all pages on the website, identifies pages marked as 'noIndex' and links marked as `noFollow`, and checks if the robots settings of the web server are set to restrict indexing.

The `Test-Website` function is a comprehensive tool for website exploration and analysis. Designed to be memory efficient, it operates non-recursively, utilizing a queue instead of recursion for URL processing. Here are the main functions it provides:

1. **Identifying broken links**: The function scans all the links of a website and identifies whether they are functional or broken.
2. **Providing a list of all pages on a site**: The function crawls through each page on the website, providing a comprehensive list of all the discovered pages.
3. **Identifying pages marked as `noIndex`**: The function checks if pages have specific directives (in HTML headers or meta tags) preventing search engines from indexing them. It returns a list of all pages marked as `noIndex`.
4. **Checking for `noFollow` links**: It checks for links on the site that are flagged as `noFollow`, indicating to search engines not to follow the link for indexing.
5. **Web Server Robots settings**: The function inspects if the robots settings of the web server (header) restrict indexing.

Here is a brief overview of its process:

- Initializes hash tables for visited URLs, `noIndex` pages, `noFollow` links, and broken links.
- Starts a while loop to visit every URL in the queue.
- Normalizes each URL and checks if it has been visited before.
- Processes each unvisited URL, gets the web response, and reads its headers.
- Checks for `noIndex` directives in the headers or meta tags of the HTML.
- Extracts all links in the document and checks for `noFollow` attributes.
- Handles relative links and only enqueues links belonging to the same domain.
- Catches exceptions for broken links and logs them.
- Returns a final object with properties for visited URLs, `noIndex` pages, `noFollow` links, and broken links.

## EXAMPLES

### Example 1: Shows broken links and more for a given url
```powershell
PS C:\> $myResult = Test-Website -url "https://eulandaconnect.eulanda.eu/" -show
PS C:\> Write-Host "NoIndex tag found: $($myResult.noIndex.count)"
PS C:\> if ($myResult.noIndex.count -gt 0) { $myResult.noIndex | ForEach-Object { Write-Host "NoIndex: $_" } }
```

```
# Result
...
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Get-DesktopDir
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Show-Extensions
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Update-Desktop
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Close-Delivery
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Out-Goodbye
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Unprotect-String
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Get-IniBool
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Hide-Extensions
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Show-MsgBoxYes
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Show-MsgBox
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Protect-String
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Convert-DataToXml
Processing: https://eulandaconnect.eulanda.eu/docs/Functions/Remove-RemoteFile
Processing: https://eulandaconnect.eulanda.eu/docs/Appendix/Fields
SUMMARY of the website analysis
===============================
Pages found: 558
NoIndex tag found: 0
NoFollow tag found: 0
Broken links found: 1
Broken: http://eulandaconnect.eulanda.eu/docs/Functions/Test-Website/ -> https://eulandaconnect.eulanda.eu/%27
```

This will crawl through the website at '[https://eulandaconnect.eulanda.eu/](https://eulandaconnect.eulanda.eu/)', showing the processing details as it goes. It will then provide a summary of the analysis, including the total number of pages found, pages with `noIndex` tags, links with `noFollow` attributes, and broken links. The result is also stored in the `$myResult` variable for further inspection.

## PARAMETERS

### -show
This is a switch parameter. If this parameter is passed, the function will output detailed processing information to the console in real time.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
This parameter expects the URL of the website to be analyzed as input. This is a mandatory parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
