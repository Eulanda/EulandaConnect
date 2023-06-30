Import-Module .\EulandaConnect.psd1

Describe "Test-Administrator" {
    It "Does not throw an exception" {
        { Test-Administrator } | Should -Not -Throw
    }
}
