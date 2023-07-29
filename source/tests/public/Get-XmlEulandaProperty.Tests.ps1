Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaProperty' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Get a property for an existing article' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        # Verify that the property is now set
        $xmlFlat = Get-XmlEulandaProperty -breadcrumbRoot '\shop' -tablename 'article' -udl $udl
        [xml]$xml = $xmlFlat
        $node = $xml.MERKMALBAUM.ARTIKEL.MERKMAL | Where-Object { $_.Name -eq 'Shop' }
        $node.Name | Should -Be 'Shop'
    }

}
