Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-AddressId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Retrieves the ID of an existing address' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = Get-AddressId -addressMatch $match -udl $udl
        $id | should -BeGreaterThan 0
    }


    It 'Retrieves the ID of an non existing address' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = Get-AddressId -addressMatch 'THIS_IS_A_WRONG_MATCH' -udl $udl
        $id | should -Be 0
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-AddressId -addressMatch $match -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-AddressId -addressMatch $match -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $id = Get-AddressId -addressMatch $match -conn $closedConn
        $id | should -BeGreaterThan 0
    }

}
