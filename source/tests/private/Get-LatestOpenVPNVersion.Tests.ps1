Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-LatestOpenVPNVersion' -Tag 'openvpn' {
    InModuleScope EulandaConnect {

        It "Does not throw exceptions" {
            {
                Get-LatestOpenVPNVersion
            } | Should -Not -Throw
        }

        It "Returns valid version schema" {
            $version = Get-LatestOpenVPNVersion
            $version | Should -Match "\d+\.\d+\.\d+"
        }
    }
}
