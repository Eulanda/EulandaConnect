Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ArticleNo' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $articleNo = '4711'
        $barcode = '1234567890123'
        $wrongBarcode = '3210987654321'

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            # Insert the necessary data into the database
            $conn = Get-Conn -udl $udl
            $sql = "INSERT INTO Artikel (ArtNummer, Barcode, Vk, Kurztext1) VALUES ($articleNo, $barcode, 42.50, 'Some Info')"
            $conn.Execute($sql)
            $conn.close()
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Retrieves existing article number' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $artNo = Get-ArticleNo -barcode $barcode -udl $udl
        $artNo | should -Be $articleNo
    }


    It 'Handles non existing article number' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $artNo = Get-ArticleNo -barcode $wrongBarcode -udl $udl
        $artNo | should -BeNullOrEmpty
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-ArticleNo -barcode $barcode -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-ArticleNo -barcode $barcode -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $artNo = Get-ArticleNo -barcode $barcode -conn $closedConn
        $artNo | should -BeGreaterThan 0
    }

}
