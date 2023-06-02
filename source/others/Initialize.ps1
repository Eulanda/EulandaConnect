
# Handle PowerShell module folder, but also the project source folder for debugging
if (Test-Path "$($PSScriptRoot)\$ecModuleName.psm1")  {
    New-Variable -Name 'ecModulePath' -Scope 'Global'  -Option ReadOnly -Force -Value "$($PSScriptRoot)\$ecModuleName.psm1" -Description 'Path including filename to the EulandaConnect module'
} elseif (Test-Path "$($PSScriptRoot)\..\..\$ecModuleName.psm1") {
    New-Variable -Name 'ecModulePath' -Scope 'Global'  -Option ReadOnly -Force -Value (Resolve-Path("$($PSScriptRoot)\..\..\$ecModuleName.psm1")).Path -Description 'Path including filename to the EulandaConnect module'
} else {
    Throw "Module '$ecModuleName.psm1' not found in '$PSScriptRoot' and also not in '$PSScriptRoot\..\..\'"
}

New-Variable -Name 'ecModuleBase' -Scope 'Global'  -Option ReadOnly -Force -Value (Split-Path $ecModulePath -Parent) -Description 'Path to the EulandaConnect module'
New-Variable -Name 'ecManifestPath' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]($ecModulePath.Replace(".psm1", ".psd1"))) -Description 'Path to the manifest of the EulandaConnect module'
New-Variable -Name 'ecManifest' -Scope 'Global'  -Option ReadOnly -Force -Value ([hashtable](Import-PowerShellDataFile -path $ecManifestPath)) -Description 'Hashtable of the EulandaConnect module manifest'
New-Variable -Name 'ecModuleVersion' -Scope 'Global'  -Option ReadOnly -Force -Value ([version]($ecManifest.ModuleVersion)) -Description 'Version number for the EulandaConnect module'
New-Variable -Name 'ecModuleCopyright' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]($ecManifest.Copyright)) -Description 'Copyright for the EulandaConnect module'
New-Variable -Name 'ecModuleLicenseUri' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]'https://www.github.com/Eulanda/EulandaConnect') -Description 'License uri for the EulandaConnect module'

New-Variable -Name 'ecStartTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'Start time of EulandaConnect module'

New-Variable -Name 'ecCulture' -Scope 'Global'  -Option ReadOnly -Force -Value ([string]([System.Threading.Thread]::CurrentThread.CurrentCulture.Name)) -Description 'User language like en-US of EulandaConnect module'

# Save the original Write-Verbose function
$originalWriteVerbose = Get-Command -Name Write-Verbose
function Write-Verbose {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Message
    )

    try {
        $depth = (Get-PSCallStack).Count - 1  # -1 to not count the own write-verbose function
    }
    catch {
        $depth = 0
    }

    $indent = " " * $depth

    & $originalWriteVerbose -Message "${indent}${Message}"
}
