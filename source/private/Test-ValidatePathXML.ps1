function Test-ValidatePathXML {
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
        if ($Extension -ne '.xml') {
            throw New-Object System.Management.Automation.ValidationMetadataException `
            -ArgumentList ((Get-ResStr 'MUST_BE_XMLFILE') -f $path)
        }
    }
    return $true
}
