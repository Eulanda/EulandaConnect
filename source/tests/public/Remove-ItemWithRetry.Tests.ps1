Import-Module .\EulandaConnect.psd1

Describe 'Remove-ItemWithRetry Tests' {
    BeforeAll {
        $tempFilePath = Join-Path -Path $env:TEMP -ChildPath 'TestFile.txt'
        Set-Content -Path $tempFilePath -Value 'This is a test file'
    }

    It 'Remove-ItemWithRetry deletes an existing file' {
        Remove-ItemWithRetry -path $tempFilePath
        Test-Path $tempFilePath | Should -Be $false
    }

    It 'Remove-ItemWithRetry does not throw an exception if the file does not exist' {
        { Remove-ItemWithRetry -path $tempFilePath } | Should -Not -Throw
    }
}
