Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ArticleId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $articleNo = '4711'
        $wrongArticleNo = '0815'

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            # Insert the necessary data into the database
            $conn = Get-Conn -udl $udl
            $sql = "INSERT INTO Artikel (ArtNummer, Vk, Kurztext1) VALUES ($articleNo, 42.50, 'Some Info')"
            $conn.Execute($sql)
            $conn.close()
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            $conn = Get-Conn -udl $udl
            $connItems = Get-ConnItems -udl $udl
            $database = $connItems.'Initial Catalog'
            $sql = @(
                "USE [master]",
                "ALTER DATABASE [$database] SET SINGLE_USER WITH ROLLBACK IMMEDIATE",
                "RESTORE DATABASE [$database] FROM DISK = '$database.BAK' WITH FILE = 2, NOUNLOAD, REPLACE, STATS = 5",
                "ALTER DATABASE [$database] SET MULTI_USER"
            )
            $conn.Execute($sql)
            $conn.Close()
        }
    }


    It 'Retrieves the ID of an existing article' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = Get-ArticleId -articleNo $articleNo -udl $udl
        $id | should -BeGreaterThan 0
    }


    It 'Retrieves the ID of an non existing article' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = Get-ArticleId -articleNo $wrongArticleNo -udl $udl
        $id | should -Be 0
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { $id = Get-ArticleId -articleNo $articleNo -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { $id = Get-ArticleId -articleNo $articleNo -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $id = Get-ArticleId -articleNo $articleNo -conn $closedConn
        $id | should -BeGreaterThan 0
    }

}
