Import-Module .\EulandaConnect.psd1

Describe 'Testing Get-TempDir function' {

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
}
