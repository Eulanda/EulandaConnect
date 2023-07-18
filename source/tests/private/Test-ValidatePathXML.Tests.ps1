Import-Module -Name .\EulandaConnect.psd1

Describe "Test-ValidatePathXML" {
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            $tempDir = [System.IO.Path]::GetTempPath()
            $testFilePath = Join-Path $tempDir "test.xml"
            $wrongFilePath = Join-Path $tempDir "wrong.txt"
            $nonExistentPath = Join-Path $tempDir "nonExistentDir\test.xml"

            Set-Content -Path $testFilePath -Value '<?xml version="1.0"?><root></root>'
            Set-Content -Path $wrongFilePath -Value 'This is not a .xml file.'
        }

        AfterAll {
            Remove-Item $testFilePath
            Remove-Item $wrongFilePath
        }

        It "Returns true when the path is valid and points to a .xml file" {
            $result = Test-ValidatePathXML -path $testFilePath
            $result | Should -BeTrue
        }

        It "Throws an error when the path points to a non-.xml file" {
            { Test-ValidatePathXML -path $wrongFilePath } | Should -Throw
        }

        It "Throws an error when the path does not exist" {
            { Test-ValidatePathXML -path $nonExistentPath } | Should -Throw
        }
    }
}
