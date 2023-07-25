Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Export-ArticleToXml' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $articleNo = '4711'
        $barcode = '1234567890123'
        $packingUnit = 12


        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            # Insert the necessary data into the database
            $conn = Get-Conn -udl $udl
            $sql = "INSERT INTO Artikel (ArtNummer, Barcode, Vk, VerpackEH, Kurztext1) VALUES ($articleNo, $barcode, 42.50, $packingUnit, 'Some Info')"
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


    It 'Exports all articles to xml' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-ArticleToXml -udl $udl
        [xml]$xml = $xmlStr
        $xml.EULANDA.ARTIKELLISTE.ARTIKEL.ARTNUMMER | should -Be $articleNo
    }


    It 'Handle filter with no result' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Export-ArticleToXml -udl $udl -filter "ArtNummer = '0815'"
        [xml]$xml = $xmlStr
        $xml.EULANDA.ARTIKELLISTE.GetType().Name | should -Be 'String'
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Export-ArticleToXml -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Export-ArticleToXml -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $xmlStr = Export-ArticleToXml -conn $closedConn
        [xml]$xml = $xmlStr
        $xml.EULANDA.ARTIKELLISTE.ARTIKEL.ARTNUMMER | should -Be $articleNo
    }

}
