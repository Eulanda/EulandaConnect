<#
    .SYNOPSIS
    Debugging Helper, to debug EulandaConnect based on single files
    .NOTES
    Version: 1.2
    .LINK
    https://github.com/Eulanda/EulandaConnect
#>

[cmdletbinding()]
Param()

Set-StrictMode -version latest
Remove-Module EulandaConnect -force -ErrorAction SilentlyContinue
Import-Module .\EulandaConnect.psd1 -force
# Import-Module .\final\EulandaConnect\EulandaConnect.psd1 -force  # in Final Folder
# Import-Module EulandaConnect  # in Standard PowerShell Module Folder
Out-Welcome -projectScript $PSCommandPath -debug:($DebugPreference -ne 'SilentlyContinue' )
Write-Host "*******************************************************************" -ForegroundColor Blue

[string]$ecHomeFolder = "$home\.eulandaconnect"

try {
    # YOUR TEST CODE HERE

    # Test-IpAddress -ip 260.1.2.3 -verbose -debug
    # Get-IpGeoInfo -ip 79.42.55.123
    # Remove-SymbolicLink
    # Confirm-System -network

    Import-TieredPrice -path 'C:\temp\test.xlsx' -articleNoName 'ARTNUMMER' -price1Name 'Vk' -tierListName 'BBY Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'


} catch {
    $errorMessage = $Error[0].ToString()
    $lineNumber = $Error[0].InvocationInfo.ScriptLineNumber
    $filePath = $Error[0].InvocationInfo.ScriptName
    if ($errorMessage -eq $_) {
        Write-Host "Exception message: $errorMessage" -ForegroundColor Red
    } else {
        Write-Host "Exception message: $errorMessage  $_" -ForegroundColor Red
    }
    Write-Host "Line number: $lineNumber" -ForegroundColor Red
    Write-Host "File path: $filePath" -ForegroundColor Red
}


Write-Host "*******************************************************************" -ForegroundColor Blue
Out-Goodbye -normally
$VerbosePreference = "SilentlyContinue"
$ErrorActionPreference = 'stop'
