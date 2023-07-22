Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-ReservedIp' {

    # Positive Tests
    It "Returns true for a reserved IP"  {
        Test-ReservedIp -ip '127.0.0.1' | Should -Be $true
    }

    It "Returns false for a non-reserved IP"  {
        Test-ReservedIp -ip '8.8.8.8' | Should -Be $false
    }

    # Negative Tests
    It "Throws an exception for an invalid IP"  {
        { Test-ReservedIp -ip '300.300.300.300' } | Should -Throw
    }

    It "Throws an exception for a non-IP string"  {
        { Test-ReservedIp -ip 'Hello World' } | Should -Throw
    }
}
