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

    $datanorm = Convert-FromDatanorm -path "$PSScriptRoot\.ignore\data\zander"
    Out-Goodbye
    Out-Welcome
    $xml = Convert-DatanormToXml -datanorm $datanorm
    Out-Goodbye
    Out-Welcome
    Import-ArticleFromXml -xml $xml -udl 'C:\temp\Eulanda_1 MeineFirma.udl' -cuSurcharge
    Out-Goodbye
    Out-Welcome


<#
    $datanorm.v
    Write-Host "A-Record" -ForegroundColor Yellow
    $datanorm.a
    Write-Host "B-Record" -ForegroundColor Yellow
    $datanorm.b
    Write-Host "P-Record" -ForegroundColor Yellow
    $datanorm.p
#>

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
