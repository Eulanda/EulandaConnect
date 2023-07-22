Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-Filename' {

    It 'returns the correct filename from a valid path' {
        $filePath = Join-Path -Path 'C:\temp' -ChildPath 'test.txt'
        Get-Filename -path $filePath | Should -Be 'test.txt'
    }

    It 'throws an exception if the path ends with a period' {
        { Get-Filename -path 'C:\temp\test.' } | Should -Throw '*A valid filepath cannot end with a period.*'
    }

    It 'throws an exception if the path ends with a backslash' {
        { Get-Filename -path 'C:\temp\' } | Should -Throw '*A valid filepath cannot end with a backslash.*'
    }

    It 'throws an exception if the path ends with a blank character' {
        { Get-Filename -path 'C:\temp\test ' } | Should -Throw '*A valid filepath cannot end with a blank character.*'
    }
}

