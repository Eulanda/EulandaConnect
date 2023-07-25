Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-NewNumberFromSeries' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $offerSeries = 'Angebot'

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Retrieves the next offer number' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $no = Get-NewNumberFromSeries -seriesName $offerSeries -udl $udl
        $no | should -Be 1 # Tests starts with an empty database
    }

    It 'Check if the offer numbers are in sequence' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $noFirst = Get-NewNumberFromSeries -seriesName $offerSeries -udl $udl
        $noSecond = Get-NewNumberFromSeries -seriesName $offerSeries -udl $udl
        $noExpected = $noFirst + 1
        $noSecond | should -Be $noExpected
    }

    It 'Handles connection errors and missing UDL file appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-NewNumberFromSeries -seriesName $offerSeries -udl $nonExistentUdl } | Should -Throw
    }

    It 'Handles invalid connection object' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $invalidConn = 'invalid connection'
        { Get-NewNumberFromSeries -seriesName $offerSeries -conn $invalidConn } | Should -Throw
    }

    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $no = Get-NewNumberFromSeries -seriesName $offerSeries -conn $closedConn
        $no | should -BeGreaterThan 0
    }

}
