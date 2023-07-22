Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateFileExists' {
    InModuleScope EulandaConnect {

        BeforeAll {
            # Create a temporary file in the Temp folder
            $filePath = Join-Path -Path $env:TEMP -ChildPath "tempFile.txt"
            Set-Content -Path $filePath -Value "This is a temporary file for testing."
        }

        It 'should return true when the file exists' {
            $result = Test-ValidateFileExists -path $filePath
            $result | Should -Be $true
        }

        It 'should throw an exception when the file does not exist' {
            # Create a path to a file that does not exist
            $nonExistentFilePath = Join-Path -Path $env:TEMP -ChildPath "nonexistentfile.txt"

            { Test-ValidateFileExists -path $nonExistentFilePath } | Should -Throw
        }

        AfterAll {
            # Remove the temporary file
            if (Test-Path $filePath) {
                Remove-Item -Path $filePath
            }
        }
    }
}
