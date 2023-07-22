Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-Numeric' {

    # Positive Tests
    It "Returns true for a numeric string" {
        Test-Numeric -value '12345' | Should -Be $true
    }

    It "Returns true for a numeric string with decimal point" {
        Test-Numeric -value '12345.67' | Should -Be $true
    }

    It "Returns true for a numeric string with zero when allowZero is enabled" {
        Test-Numeric -value '0' -allowZero | Should -Be $true
    }

    It "Returns true for a string with numeric and zero when allowZero is enabled" {
        Test-Numeric -value '123450' -allowZero | Should -Be $true
    }

    # Negative Tests
    It "Returns false for a non-numeric string" {
        Test-Numeric -value 'Hello' | Should -Be $false
    }

    It "Returns false for an empty string" {
        Test-Numeric -value '' | Should -Be $false
    }

    It "Returns false for a numeric string with comma" {
        Test-Numeric -value '123,45' | Should -Be $false
    }

    It "Returns false for a numeric string with zero when allowZero is not enabled" {
        Test-Numeric -value '0' | Should -Be $false
    }
}
