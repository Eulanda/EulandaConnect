function Test-ValidatePathUDL {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [Alias('udl')]
        [string]$path
    )

    if ($path) {
        $Extension = [System.IO.Path]::GetExtension($path)
        $pathOnly = Split-Path $path

        if (!(Test-Path $pathOnly)) {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'PATH_NOT_EXISTS') -f $path)
        }
        if ($Extension -ne '.udl') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_UDLFILE') -f $path)
        }
    }
    return $true
}
