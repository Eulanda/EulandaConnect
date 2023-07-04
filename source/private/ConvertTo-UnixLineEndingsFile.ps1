Function ConvertTo-UnixLineEndingsFile {
    [CmdletBinding()]
    param(
        [string]$path
    )

    $content = Get-Content -Path $path -Raw
    $unixLineEnding = "`n"

    # Check if the line break format is CRLF
    if ($content -match "`r`n") {
        # If yes, convert it to LF
        $content = $content -replace "`r`n", $unixLineEnding
    }

    $content | Set-Content -Path $path -NoNewline
}
