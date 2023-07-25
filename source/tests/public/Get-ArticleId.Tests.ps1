Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ArticleId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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

        $id = Get-ArticleId -articleNo '0815' -udl $udl
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
