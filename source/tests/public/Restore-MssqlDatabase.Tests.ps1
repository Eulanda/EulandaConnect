Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Restore-MssqlDatabase' -Tag 'integration', 'sql', 'sqladmin' {

    BeforeAll {
        $pesterFolder = Resolve-Path -path ".\source\tests"
        $udl = "$pesterFolder\Eulanda_1 Pester.udl"
        $articleNo = '4711'

        # SQL needs sysadmin rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

             # Insert the necessary data into the database
             $conn = Get-Conn -udl $udl
             $sql = "INSERT INTO Artikel (ArtNummer, Vk, Kurztext1) VALUES ('$articleNo', 42.50, 'Some Info')"
             $conn.Execute($sql)
             $conn.close()
        }
    }


    It 'After restore the added artcles should be missed' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        Restore-MssqlDatabase -udl $udl
        $id = Get-ArticleId -articleNo $articleNo -udl $udl
        $id | should -Be 0
    }
}
