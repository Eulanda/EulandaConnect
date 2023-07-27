Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-BreadcrumbId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"
        $tablename = 'article'

        # Uses predefined path and id at the moment, the test database has this already set on creating
        $breadcrumbPath = '\shop\hardware'
        $breadcrumbId = 49
    }


    It 'Retrieves the ID of an existing breadcrumb path' {
        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath $breadcrumbPath -udl $udl
        $id | should -Be $breadcrumbId
    }


    It 'Retrieves the ID of an non existing breadcrumb path' {
        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath '\shop\NotExisting' -udl $udl
        $id | should -Be (-1)
    }

    It 'Exception on not existing tablename' {
        { Get-BreadcrumbId -tablename 'NonExistingTablename' -breadcrumbPath $breadcrumbPath -udl $udl } | Should -Throw
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-BreadcrumbId  -tablename $tablename -breadcrumbPath $breadcrumbPath -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles invalid connection object' {
        $invalidConn = 'invalid connection'
        { Get-BreadcrumbId  -tablename $tablename -breadcrumbPath $breadcrumbPath  -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $id = Get-BreadcrumbId -tablename $tablename -breadcrumbPath $breadcrumbPath -conn $closedConn
        $id | should -Be $breadcrumbId
    }

}
