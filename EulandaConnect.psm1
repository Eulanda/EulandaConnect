<#
    .SYNOPSIS
    A debugging helper module for functions in the EulandaConnect module.

    .DESCRIPTION
    This module is intended to aid in debugging the ps1 files in both the
    private and public folders of the EulandaConnect module.
    It is recommended that a debug project be created in the root of
    the project in order to load this module using the following command:

    Import-Module "C:\Git\Powershell\EulandaConnect\EulandaConnect.psm1" -force

    LEAVE THIS UNCHANGED, IT HAS TO WORK LIKE IT IS.
#>

Write-Verbose -Message ('Starting: {0}' -f $myInvocation.Mycommand)

Get-Module -Name "EulandaConnect" -All | ForEach-Object {
    Remove-Module -ModuleInfo $_ -ErrorAction SilentlyContinue
}

$params = @{
    Filter      = '*.ps1'
    Recurse     = $true
    ErrorAction = 'Stop'
}
try {

    [string]$path = $PSScriptRoot
    if (! $path) {
        $path = 'C:\Git\Powershell\EulandaConnect'
    }

    # Set-StrictMode is set in variables.ps1
    $variables = @(Get-ChildItem -Path "$path\source\others\Variables.ps1")
    $initialize = @(Get-ChildItem -Path "$path\source\others\Initialize.ps1")
    $public = @(Get-ChildItem -Path "$path\source\public" @params)
    $private = @(Get-ChildItem -Path "$path\source\private" @params)
}
catch {
    Write-Error $_
    throw 'Debug-Helper EulandaConnect.psm1: Unable to read source files from public or private.'
}

# Import all files as dot-source
foreach ($file in @($variables + $initialize + $public + $private)) {
    try {
        Write-Verbose "$($file.FullName)"
        . $file.FullName
    }
    catch {
        throw "Debug-Helper EulandaConnect.psm1: Unable to import file [$($file.FullName)]. ERROR: $_"

    }
}
Export-ModuleMember -Variable *
Export-ModuleMember -Function $public.Basename
