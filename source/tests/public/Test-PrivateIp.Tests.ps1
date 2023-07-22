Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-PrivateIp' {

    It "returns true for a private IP address" {
        $result = Test-PrivateIp -ip '192.168.178.2'
        $result | Should -Be $true
    }

    It "returns false for a public IP address" {
        $result = Test-PrivateIp -ip '8.8.8.8'
        $result | Should -Be $false
    }

    It "throws an exception when no IP parameter is provided" {
        { Test-PrivateIp } | Should -Throw
    }
}
