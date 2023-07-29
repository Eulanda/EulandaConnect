Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Export-PropertyToXml' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Exports properties from root to xml' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-PropertyToXml -breadcrumbRoot '\' -tablename 'article' -udl $udl
        [xml]$xml = $xmlStr
        $node = $xml.EULANDA.MERKMALBAUM.ARTIKEL.MERKMAL.MERKMAL | Where-Object { $_.Name -eq 'Shop' }
        $node.Name | Should -Be 'Shop'
    }


    It 'Exports properties from folder \shop to xml' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-PropertyToXml -breadcrumbRoot '\Shop' -tablename 'article' -udl $udl
        [xml]$xml = $xmlStr
        $node = $xml.EULANDA.MERKMALBAUM.ARTIKEL.MERKMAL | Where-Object { $_.Name -eq 'Shop' }
        $node.Name | Should -Be 'Shop'
    }


    It 'Exports properties to xml without breadcrumpRoot' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        { Export-PropertyToXml -tablename 'article' -udl $udl } | Should -Throw
    }

}
