Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-MaxHosts' {

    # Test if no subnet or CIDR values are provided, the function should retrieve the
    # subnet from the local IP and calculate the number of hosts
    It 'Should retrieve subnet from local IP and calculate the number of hosts when no subnet or CIDR is provided' {
        $hosts = Get-MaxHosts
        $hosts | Should -BeGreaterThan 0
    }

    # Test, if a CIDR value is provided, the function should calculate the number of hosts accordingly
    It 'Should calculate the number of hosts according to the provided CIDR value' {
        $hosts = Get-MaxHosts -cidr 30
        $hosts | Should -Be 2
    }

    # Tests if an invalid CIDR value is provided, the function should return a neg. value
    It 'Should return a negative value when an invalid CIDR value is provided' {
        $hosts = Get-MaxHosts -cidr 33
        $hosts | Should -BeLessThan 0
    }

}
