Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-LastIp' {

    It "Runs without throwing" {
        { Get-LastIp } | Should -Not -Throw
    }

    It "Returns the correct IP when networkId and cidr are specified" {
        $lastIp = Get-LastIp -networkId "192.168.172.8" -cidr 30
        $lastIp | Should -Be "192.168.172.10"
    }

    It "Doesn't return an empty string" {
        Get-LastIp | Should -Not -BeNullOrEmpty
    }
}
