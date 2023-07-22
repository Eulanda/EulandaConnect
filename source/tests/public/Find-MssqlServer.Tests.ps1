Import-Module -Name .\EulandaConnect.psd1

Describe 'Find-MssqlServer' -Tag 'integration', 'admin', 'sql' {

    BeforeAll {
        $isAdmin = Test-Administrator
        if (-not $isAdmin) {
            Write-Warning "These tests require administrator rights. Run the tests as administrator."
        }
    }


    It 'returns the expected object type when valid IP is provided' {
        if ($isAdmin) {
            $result = Find-MssqlServer -localIp '127.0.0.1' -force
            $result | Should -Not -BeNullOrEmpty
            $result[0] | Should -BeOfType [PSCustomObject]
        } else {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }
    }

    It 'should contain expected properties when valid IP is provided' {
        if ($isAdmin) {
            $result = Find-MssqlServer -localIp '127.0.0.1' -force
            $result[0].Ip.IpAddressToString | Should -Not -BeNullOrEmpty
            $result[0].InstanceName | Should -Not -BeNullOrEmpty
        } else {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }
    }

    It 'should return result within timeout when valid IP is provided' {
        if ($isAdmin) {
            $timeoutSeconds = 2
            $startTime = Get-Date
            $result = Find-MssqlServer -localIp '127.0.0.1' -timeoutSeconds $timeoutSeconds -force
            $elapsedTime = (Get-Date) - $startTime
            $elapsedTime.TotalSeconds | Should -BeLessThan ($timeoutSeconds + 1)  # Allow a little grace period
        } else {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }
    }
}
