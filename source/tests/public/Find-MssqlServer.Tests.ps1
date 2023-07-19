
Import-Module -Name .\EulandaConnect.psd1

Describe 'Find-MssqlServer' {
    It 'returns the expected object type when valid IP is provided' {
        $result = Find-MssqlServer -localIp '127.0.0.1'
        $result | Should -Not -BeNullOrEmpty
        $result[0] | Should -BeOfType [PSCustomObject]
    }

    It 'should contain expected properties when valid IP is provided' {
        $result = Find-MssqlServer -localIp '127.0.0.1'
        $result[0].Ip.IpAddressToString | Should -Not -BeNullOrEmpty
        $result[0].InstanceName | Should -Not -BeNullOrEmpty
    }

    It 'should return result within timeout when valid IP is provided' {
        $timeoutSeconds = 2
        $startTime = Get-Date
        $result = Find-MssqlServer -localIp '127.0.0.1' -timeoutSeconds $timeoutSeconds
        $elapsedTime = (Get-Date) - $startTime
        $elapsedTime.TotalSeconds | Should -BeLessThan ($timeoutSeconds + 1)  # Allow a little grace period
    }

}
