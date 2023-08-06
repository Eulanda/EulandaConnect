Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-BreadcrumbPath' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Uses predefined path and id at the moment, the test database has this already set on creating
        $breadcrumbPath = '\shop\hardware'
        $breadcrumbId = 55
    }


    It 'Retrieves the path of an existing breadcrumb id' {
        $path = Get-BreadcrumbPath -breadcrumbId $breadcrumbId -udl $udl
        $path | should -Be $breadcrumbPath
    }


    It 'Retrieves the path of an non existing breadcrumb id' {
        $path = Get-BreadcrumbPath -breadcrumbId 999999 -udl $udl
        $path | should -BeNullOrEmpty
    }


    It 'Handles connection errors and missing UDL file appropriately' {
        $nonExistentUdl = 'C:\path\to\nonexistent.udl'
        { Get-BreadcrumbPath -breadcrumbId $breadcrumbId -udl $nonExistentUdl } | Should -Throw
    }


    It 'Handles connection errors and no connection parameter' {
        $sql = Get-BreadcrumbPath -breadcrumbId $breadcrumbId

        # Check if the SQL code contains the important parts
        $sql.Contains('DECLARE @BreadcrumbPath varchar(1024);') | Should -Be $true
        $sql.Contains('DECLARE @ID int') | Should -Be $true
        $sql.Contains('WITH CTE AS') | Should -Be $true
        $sql.Contains('FROM Merkmal') | Should -Be $true
        $sql.Contains('SELECT TOP 1 @BreadcrumbPath=Pfad') | Should -Be $true
        $sql.Contains('SET @BreadcrumbPath = SUBSTRING') | Should -Be $true

        # Check if the BreadcrumbId is inserted correctly
        $sql.Contains("@ID int = $breadcrumbId") | Should -Be $true
    }


    It 'Handles invalid connection object' {
        $invalidConn = 'invalid connection'
        { Get-BreadcrumbPath  -breadcrumbId $breadcrumbId -conn $invalidConn } | Should -Throw
    }


    It 'Handles closed database connection appropriately' {
        $closedConn = Get-Conn -udl $udl
        $closedConn.close() # close it
        $path = Get-BreadcrumbPath  -breadcrumbId $breadcrumbId -conn $closedConn
        $path | should -Be $breadcrumbPath
    }

}
