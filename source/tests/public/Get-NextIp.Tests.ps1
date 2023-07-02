Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-NextIp' {

    It 'Should get the next IP with no increment' {
        Get-NextIp -ip '192.168.178.20' | Should -Be '192.168.178.21'
    }

    It 'Should get the next IP with increment of 5' {
        Get-NextIp -ip '192.168.178.20' -inc 5 | Should -Be '192.168.178.25'
    }

    It 'Should correctly handle overflow' {
        Get-NextIp -ip '192.168.178.255' -inc 5 | Should -Be '192.168.179.4'
    }

    It 'Should correctly handle large increments' {
        Get-NextIp -ip '192.168.178.20' -inc 300 | Should -Be '192.168.179.64'
    }

    It 'Should return 0.0.0.0 for invalid IP address' {
        Get-NextIp -ip 'invalid.ip' | Should -Be '0.0.0.0'
    }
}
