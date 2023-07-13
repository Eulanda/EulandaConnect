Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-FirstIp' {

    It 'Get-FirstIp should return the next IP for the subnet 255.255.255.0' {
        Get-FirstIp -cidr 24 -NetworkId '192.168.1.0' | Should -Be '192.168.1.1'
    }

    It 'Get-FirstIp should return the next IP for a different subnet' {
        Get-FirstIp -cidr 16 -NetworkId '192.168.2.0' | Should -Be '192.168.2.1'
    }

    It 'Get-FirstIp should return the first IP in a new subnet' {
        Get-FirstIp -cidr 8 -NetworkId '192.168.3.0' | Should -Be '192.168.3.1'
    }
}
