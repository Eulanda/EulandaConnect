Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-BroadcastIp' {

    It "Runs without throwing" {
        { Get-LastIp } | Should -Not -Throw
    }

    It "Returns the correct IP when networkId and cidr are specified" {
        $lastIp = Get-BroadcastIp -networkId "192.168.172.8" -cidr 30
        $lastIp | Should -Be "192.168.172.11"
    }

    It "Doesn't return an empty string" {
        Get-BroadcastIp | Should -Not -BeNullOrEmpty
    }
}
