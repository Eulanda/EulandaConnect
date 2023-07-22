Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-NetworkId' {

    It "Runs without throwing" {
        { Get-NetworkId -ip '192.168.178.9' -cidr 30 } | Should -Not -Throw
    }

    It "Returns correct network ID for given IP and CIDR" {
        $result = Get-NetworkId -ip '192.168.178.9' -cidr 30
        $result | Should -Be '192.168.178.8'
    }

    It "Returns '0.0.0.0' when given an invalid IP" {
        $result = Get-NetworkId -ip 'InvalidIp' -cidr 30
        $result | Should -Be '0.0.0.0'
    }

    It "Returns correct network ID for local IP and CIDR when no IP is provided" {
        $localIp = Get-LocalIp
        $localCidr = Get-Cidr -ip $localIp
        $expectedResult = Get-NetworkId -ip $localIp -cidr $localCidr
        $result = Get-NetworkId -cidr $localCidr
        $result | Should -Be $expectedResult
    }
}
