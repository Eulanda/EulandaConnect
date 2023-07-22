Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-Administrator' {

    It "Does not throw an exception" {
        { Test-Administrator } | Should -Not -Throw
    }
}
