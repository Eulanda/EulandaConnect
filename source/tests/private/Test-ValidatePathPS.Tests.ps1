Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-ValidatePathPS' {
    InModuleScope EulandaConnect {

        BeforeAll {
            $tempDir = [System.IO.Path]::GetTempPath()
            $testFilePath = Join-Path $tempDir "test.ps1"
            $wrongFilePath = Join-Path $tempDir "wrong.txt"
            $nonExistentPath = Join-Path $tempDir "nonExistentDir\test.ps1"

            Set-Content -Path $testFilePath -Value 'Write-Host "Hello, World!"'
            Set-Content -Path $wrongFilePath -Value 'This is not a .ps1 file.'
        }

        AfterAll {
            Remove-Item $testFilePath
            Remove-Item $wrongFilePath
        }

        It "Returns true when the path is valid and points to a .ps1 file" {
            $result = Test-ValidatePathPS -path $testFilePath
            $result | Should -BeTrue
        }

        It "Throws an error when the path points to a non-.ps1 file" {
            { Test-ValidatePathPS -path $wrongFilePath } | Should -Throw
        }

        It "Throws an error when the path does not exist" {
            { Test-ValidatePathPS -path $nonExistentPath } | Should -Throw
        }
    }
}
