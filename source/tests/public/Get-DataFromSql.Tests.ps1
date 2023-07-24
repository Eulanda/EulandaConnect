Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DataFromSql' -Tag 'integration', 'sql' {

    It 'Throws an error when no sql parameter is passed' {
        { Get-DataFromSql } | Should -Throw
    }

}


Describe 'Get-DataFromSql' -Tag 'integration', 'sql', 'sqladmin' {
    InModuleScope EulandaConnect {

        BeforeAll {
            $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

            $skipTest = -not (Test-MssqlAdministrator -udl $udl)

            if (! $skipTest) {
                # Backup the database
                $sql = "BACKUP DATABASE [Eulanda_Pester] TO  DISK = 'Eulanda_Pester.bak' WITH NOFORMAT, NOINIT,  NAME = 'Eulanda_Pester-Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10"
                $conn.Execute($sql)

                # Insert the necessary data into the database
                $sql = "INSERT INTO Artikel (ArtNummer, Vk, Kurztext1) VALUES ('4711', 42.50, 'Some Info')"
                $conn.Execute($sql)
                $conn.Close()
            }
        }

        AfterAll {
            if (! $skipTest) {
                # Restore the database
                $conn = Get-Conn -udl $udl
                $sql = @(
                    "USE [master]",
                    "ALTER DATABASE [Eulanda_Pester] SET SINGLE_USER WITH ROLLBACK IMMEDIATE",
                    "RESTORE DATABASE [Eulanda_Pester] FROM DISK = 'Eulanda_Pester.BAK' WITH FILE = 2, NOUNLOAD, REPLACE, STATS = 5",
                    "ALTER DATABASE [Eulanda_Pester] SET MULTI_USER"
                )
                $conn.Execute($sql)
                $conn.Close()
            }
        }

        It 'Fetches data from the database' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            $conn = Get-Conn -udl $udl
            $sql = @("SELECT ArtNummer, Vk, Kurztext1 FROM Artikel WHERE ArtNummer = '4711'")
            $result = Get-DataFromSql -sql $sql -conn $conn

            $result.Count | Should -Be 3
            $result.ArtNummer | Should -BeExactly '4711'
            $result.Vk | Should -BeExactly 42.50
            $result.Kurztext1 | Should -BeExactly 'Some Info'
            $conn.Close()
        }
    }
}
