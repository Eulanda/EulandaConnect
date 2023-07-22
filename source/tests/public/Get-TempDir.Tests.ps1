Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-TempDir' {

    It 'should return path to Temp directory' {
        $result = Get-TempDir
        $expectedResult = [System.IO.Path]::GetTempPath().TrimEnd('\')
        $result | Should -Be $expectedResult
    }

    It 'should not return path ending with a backslash' {
        $result = Get-TempDir
        $result.EndsWith('\') | Should -Be $false
    }

    It 'should not return a single backslash' {
        $result = Get-TempDir
        $result | Should -Not -Be '\'
    }

   It "should return a valid path" {
        $result = Get-TempDir
        { Test-Path -Path $result -IsValid } | Should -Not -Throw
    }
}
