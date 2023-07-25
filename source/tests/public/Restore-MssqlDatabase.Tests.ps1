Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Restore-MssqlDatabase' -Tag 'integration', 'sql', 'sqladmin' {

    BeforeAll {
        $pesterFolder = Resolve-Path -path ".\source\tests"
        $udl = "$pesterFolder\Eulanda_1 Pester.udl"

        # SQL needs sysadmin rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertArticle.ps1
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
