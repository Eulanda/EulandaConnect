Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-Hostname' {

    It 'should return a valid hostname when provided without an IP' {
        $hostname = Get-Hostname
        $hostname | Should -Not -BeNullOrEmpty
    }

    It 'should return empty string when provided with invalid IP' {
        $hostname = Get-Hostname -ip '300.300.300.300'
        $hostname | Should -Be ''
    }
}
