Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-MssqlInstances' {

    BeforeAll {
        $isAdmin = Test-Administrator
        if (-not $isAdmin) {
            Write-Warning "These tests require administrator rights. Run the tests as administrator."
        }
    }

    It 'Runs without throwing' {
        { Get-MssqlInstances } | Should -Not -Throw
    }

    It 'Returns an ArrayList'  {
        if (-not $isAdmin) {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }

        $result = Get-MssqlInstances
        $result | Should -BeOfType 'System.Collections.ArrayList'
    }

    It 'Returns correct object structure' {
        $result = Get-MssqlInstances

        # Check each item in the result
        foreach ($item in $result) {
            # List all the properties of the item
            $properties = $item.PSObject.Properties.Name

            # Check each property
            $properties -contains "Instance" | Should -Be $true
            $properties -contains "Version" | Should -Be $true
            $properties -contains "PatchLevel" | Should -Be $true
            $properties -contains "Collation" | Should -Be $true
            $properties -contains "BinnPath" | Should -Be $true
            $properties -contains "DataPath" | Should -Be $true
            $properties -contains "BackupPath" | Should -Be $true
            $properties -contains "SqlService" | Should -Be $true
            $properties -contains "BrowserService" | Should -Be $true
            $properties -contains "TcpIp" | Should -Be $true
            $properties -contains "SharedMemory" | Should -Be $true
            $properties -contains "NamedPipes" | Should -Be $true
            $properties -contains "PipeName" | Should -Be $true
            $properties -contains "FirewallChecked" | Should -Be $true
            $properties -contains "SqlBrowserRule" | Should -Be $true
            $properties -contains "SqlServerRule" | Should -Be $true
            $properties -contains "Files" | Should -Be $true
        }
    }
}
