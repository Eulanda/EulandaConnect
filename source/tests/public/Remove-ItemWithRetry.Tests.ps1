Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-ItemWithRetry' {

    BeforeAll {
        $testPath = "$env:TEMP\testfile.txt"
        $testDir = "$env:TEMP\testDir"
        $testNestedDir = "$env:TEMP\testDir\nestedDir"

        # Create a test file and directories
        New-Item -ItemType File -Path $testPath -Force | Out-Null
        New-Item -ItemType Directory -Path $testDir -Force | Out-Null
        New-Item -ItemType Directory -Path $testNestedDir -Force | Out-Null
    }

    It 'Should delete a regular file' {
        Remove-ItemWithRetry -path $testPath
        Test-Path $testPath | Should -Be $false
    }

    It 'Should delete a directory and its subdirectories in the temp directory' {
        Remove-ItemWithRetry -path $testDir
        Test-Path $testDir | Should -Be $false
    }

    It 'Remove-ItemWithRetry does not throw an exception if the file does not exist' {
        $tempFilePath = Join-Path -Path $env:TEMP -ChildPath 'TestFile.txt'
        Set-Content -Path $tempFilePath -Value 'This is a test file'
        { Remove-ItemWithRetry -path $tempFilePath } | Should -Not -Throw
    }

    AfterAll {
        # Cleanup any remaining test files/directories
        if (Test-Path $testPath) {
            Remove-Item -Path $testPath -Force -ErrorAction Ignore | Out-Null
        }

        if (Test-Path $testDir) {
            Remove-Item -Path $testDir -Force -Recurse -ErrorAction Ignore | Out-Null
        }
    }
}
