Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaAddress' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $match = 'JOHN'

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            # Insert the necessary data into the database
            $conn = Get-Conn -udl $udl
            $sql =  "INSERT INTO Adresse ([Match], Name1, Strasse, Plz, Ort, Karteikarte) " + `
                    "VALUES ('$match', 'John Doe', 'Star Avenue 42', '12345', 'Fantasy Town', 'Some Info')"
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


    It 'Get all addresses as xml string' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Get-XmlEulandaAddress -filter "Match = '$match'" -udl $udl
        [xml]$xml = $xmlStr
        $xml.ADRESSELISTE.ADRESSE.MATCH | should -Be $match
    }


    It 'Handle filter with no result' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        [string]$xmlStr = Get-XmlEulandaAddress -udl $udl -filter "Match = '0815'"
        $xmlStr | should -BeNullOrEmpty
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-XmlEulandaAddress -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-XmlEulandaAddress -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $xmlStr = Get-XmlEulandaAddress -filter "Match = '$match'" -conn $closedConn
        [xml]$xml = $xmlStr
        $xml.ADRESSELISTE.ADRESSE.MATCH | should -Be $match
    }

}
