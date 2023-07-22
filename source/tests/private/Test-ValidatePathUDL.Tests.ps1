Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidatePathUDL' {
    InModuleScope EulandaConnect {

        BeforeAll {
            $tempDir = [System.IO.Path]::GetTempPath()
            $testFilePath = Join-Path $tempDir "test.udl"
            $wrongFilePath = Join-Path $tempDir "wrong.txt"
            $nonExistentPath = Join-Path $tempDir "nonExistentDir\test.udl"

            Set-Content -Path $testFilePath -Value 'Data Source=MySqlServer;Initial Catalog=MySqlDatabase;'
            Set-Content -Path $wrongFilePath -Value 'This is not a .udl file.'
        }

        AfterAll {
            Remove-Item $testFilePath
            Remove-Item $wrongFilePath
        }

        It "Returns true when the path is valid and points to a .udl file" {
            $result = Test-ValidatePathUDL -path $testFilePath
            $result | Should -BeTrue
        }

        It "Throws an error when the path points to a non-.udl file" {
            { Test-ValidatePathUDL -path $wrongFilePath } | Should -Throw
        }

        It "Throws an error when the path does not exist" {
            { Test-ValidatePathUDL -path $nonExistentPath } | Should -Throw
        }
    }
}
