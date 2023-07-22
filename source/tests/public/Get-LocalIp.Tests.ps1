Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-LocalIp' {

    It "Runs without throwing" {
        { Get-LocalIp } | Should -Not -Throw
    }

    It "Doesn't return an empty string" {
        Get-LocalIp | Should -Not -BeNullOrEmpty
    }

    It "Returns a valid IP address" {
        $ip = Get-LocalIp
        $ip | Should -Match '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
    }

    It "Returns an IP address from the local address space" {
        $ip = Get-LocalIp
        $ip | Should -Match '^(10\.\d{1,3}\.\d{1,3}\.\d{1,3}|172\.(1[6-9]|2\d|3[0-1])\.\d{1,3}\.\d{1,3}|192\.168\.\d{1,3}\.\d{1,3})$'
    }
}
