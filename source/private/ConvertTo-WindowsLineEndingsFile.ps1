Function ConvertTo-WindowsLineEndingsFile {
    [CmdletBinding()]
    param(
        [string]$path
    )

    $content = Get-Content -Path $path -Raw
    $content = $content -replace "`r`n","`n" -replace "`n","`r`n"
    $content | Set-Content -Path $path -NoNewline
}
