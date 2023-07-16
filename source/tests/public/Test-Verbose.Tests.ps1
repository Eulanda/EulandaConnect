Import-Module -Name .\EulandaConnect.psd1

Describe "Test-Verbose" {
    It "Runs without throwing" {
        { Test-Verbose } | Should -Not -Throw
    }

    It "Runs and returns true" {
        Test-Verbose -verbose| Should -BeTrue
    }

    It "Runs and returns false" {
        Test-Verbose | Should -BeFalse
    }
}
