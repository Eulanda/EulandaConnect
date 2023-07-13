Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-GatewayIp' {

    It 'should return a valid IP address' {
        $ip = Get-GatewayIp
        $ip -match "^(\d{1,3}\.){3}\d{1,3}$" | Should -BeTrue
    }
}
