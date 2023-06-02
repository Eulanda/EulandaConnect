function Test-ValidatePathPS {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path
    )

    if ($path) {
        $Extension = [System.IO.Path]::GetExtension($path)
        $pathOnly = Split-Path $path

        if (!(Test-Path $pathOnly)) {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'PATH_NOT_EXISTS') -f $path)
        }
        if ($Extension -ne '.ps1') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_PS1FILE') -f $path)
        }
    }
    return $true
}
