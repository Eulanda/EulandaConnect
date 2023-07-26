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

            # Test-MssqlAdministartor rights
            $skipTest = -not (Test-MssqlAdministrator -udl $udl)

            # Skip backup because for restoring you need special rights
            if (! $skipTest) {
                Backup-MssqlDatabase -udl $udl

                . source\tests\include\Include-InsertArticle.ps1
            }
        }

        AfterAll {
            if (! $skipTest) {
                Restore-MssqlDatabase -udl $udl
            }
        }

        It 'Fetches data from the database' {
            if ($skipTest) {
                Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
                Return
            }

            $conn = Get-Conn -udl $udl
            $sql = @("SELECT ArtNummer, Vk, Kurztext1 FROM Artikel WHERE ArtNummer = '$articleNo'")
            $result = Get-DataFromSql -sql $sql -conn $conn

            $result.Count | Should -Be 3
            $result.ArtNummer | Should -BeExactly $articleNo
            $result.Vk | Should -BeExactly 42.50
            $result.Kurztext1 | Should -BeExactly $text
            $conn.Close()
        }
    }
}
