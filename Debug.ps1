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

    # $datanorm = Convert-FromDatanorm -path "$PSScriptRoot\.ignore\data\zander" -show
    # $xml = Convert-DatanormToXml -datanorm $datanorm -show
    # Import-ArticleFromXml -xml $xml -udl 'C:\temp\Eulanda_1 MeineFirma.udl' -cuSurcharge -show

    # $i = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
    # $headId = New-PurchaseOrder -supplierID 15 -processedBy 'EulandaConnect'  -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
    # $posId = New-PurchaseOrderLineItem -purchaseOrderId $kopfId -articleNo '0000460' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
    # Write-Host $headId - $posId

    # $temp = Remove-UrlFragment -url 'entwu#rf-die-b&#xE4;nder-3'
    # $temp


    # $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    # & $Features {
    #  New-OpenVpnTls -openVpnPath  "$($env:ProgramFiles)\OpenVPN" -destination "$($home)\.eulandaconnect\pester\OpenVPN"
    # }

    Export-ArticleToXml -udl '.\source\tests\Eulanda_1 Pester.udl'


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
