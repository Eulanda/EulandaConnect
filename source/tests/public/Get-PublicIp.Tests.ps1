Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-PublicIp' {

    It "Returns a valid public IP address" {
        # Invoke function
        $result = Get-PublicIp

        # Check that the result is a valid IP address
        $result | Should -Match '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
    }
}
