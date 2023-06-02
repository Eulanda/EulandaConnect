Import-Module .\EulandaConnect.psd1

Describe "Test-IpAddress" {
    It "returns true for a valid IP address" {
        $result = Test-IpAddress -ip '192.168.178.2'
        $result | Should -Be $true
    }

    It "returns false for an invalid IP address" {
        $result = Test-IpAddress -ip '260.1.2.3'
        $result | Should -Be $false
    }

    It "throws an exception when no IP parameter is provided" {
        { Test-IpAddress } | Should -Throw
    }
}
