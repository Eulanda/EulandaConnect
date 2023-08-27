Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-BreadcrumbId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $tablename = 'article'

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

            . source\tests\include\Include-InsertProperty.ps1
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Retrieves the ID of an existing breadcrumb path' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath $hardwarePath -udl $udl
        $id | should -Be $hardwareId
    }


    It 'Retrieves the ID of an non existing breadcrumb path' {
        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath '\shop\NotExisting' -udl $udl
        $id | should -Be (-1)
    }

    It 'Exception on not existing tablename' {
        { Get-BreadcrumbId -tablename 'NonExistingTablename' -breadcrumbPath $hardwarePath -udl $udl } | Should -Throw
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-BreadcrumbId  -tablename $tablename -breadcrumbPath $hardwarePath -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        $invalidConn = 'invalid connection'
        { Get-BreadcrumbId  -tablename $tablename -breadcrumbPath $hardwarePath  -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath $hardwarePath -conn $closedConn
        $id | should -Be $hardwareId
    }

}
