Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-Console' {

    It "Does not throw an exception" {
        { Test-Console } | Should -Not -Throw
    }
}
