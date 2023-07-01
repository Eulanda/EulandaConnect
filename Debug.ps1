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


    $pesterFolder = Resolve-Path -path ".\source\tests"
    $iniPath = Join-Path -path $pesterFolder "pester.ini"
    $ini = Read-IniFile -path $iniPath
    $path = $ini['SFTP']['SecurePasswordPath']
    $path = $path -replace '\$home', $HOME
    $secure = Import-Clixml -path $path
    $server = $ini['SFTP']['Server']
    $user = $ini['SFTP']['User']

    $localFolder = Join-Path -path (Get-Location) source tests
    # Send-FtpFile -server $server -user $user -password $secure -remoteFolder "/inbox" -localFolder "$localFolder" -localFile 'Readme.md'
    Send-FtpFile -server $server -user $user -password $secure -remoteFolder '/inbox' -remoteFile 'test.txt' -localFolder 'C:\temp' -localFile 'text.txt'
    $result = Get-FtpDir -server $server -user $user -password $secure -remoteFolder "/inbox"
    Write-Host "'$result' are all files on ftp inbox folder"


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
