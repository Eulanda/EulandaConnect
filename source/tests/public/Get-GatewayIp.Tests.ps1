Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-GatewayIp' {

    It 'should return a valid IP address' {
        $ip = Get-GatewayIp
        $ip -match "^(\d{1,3}\.){3}\d{1,3}$" | Should -BeTrue
    }
}
