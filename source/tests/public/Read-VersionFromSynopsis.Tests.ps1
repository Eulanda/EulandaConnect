Import-Module .\EulandaConnect.psd1

Describe 'Read-VersionFromSynopsis Tests' {
    BeforeAll {
        $testFileContent = @'
<#
.SYNOPSIS
    This is a test script.

.DESCRIPTION
This script was created for testing only.

.NOTES
    Version: 1.5
#>

# Random line of code
Write-Host 'Hallo, World!'
'@

        $tempFilePath = Join-Path -Path $env:TEMP -ChildPath 'TestScript.ps1'
        Set-Content -Path $tempFilePath -Value $testFileContent
    }

    It 'Read-VersionFromSynopsis reads the correct version from the synopsis' {
        $version = Read-VersionFromSynopsis -path $tempFilePath
        $version | Should -Be ([version]'1.5')
    }

    AfterAll {
        Remove-Item -Path $tempFilePath
    }
}
