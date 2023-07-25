Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ArticlePackingUnit' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Retrieves packing unit for existing article number' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $unit = Get-ArticlePackingUnit -articleNo $articleNo -udl $udl
        $unit | should -Be $packingUnit
    }


    It 'Handles non existing article number' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $unit = Get-ArticlePackingUnit -articleNo '0815' -udl $udl
        $unit | should -Be 0
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-ArticlePackingUnit -barcode $barcode -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-ArticlePackingUnit -barcode $barcode -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $unit = Get-ArticlePackingUnit -barcode $barcode -conn $closedConn
        $unit | should -Be $packingUnit
    }
}
