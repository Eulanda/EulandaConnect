Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-Console' {

    It "Does not throw an exception" {
        { Test-Console } | Should -Not -Throw
    }
}
