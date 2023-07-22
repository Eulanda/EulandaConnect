Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ConnStr' -Tag 'integration', 'mock' {

    BeforeAll {
        $udl = Resolve-Path '.\source\tests\EULANDA_1 Pester.udl'
    }

    It "Returns a connection string when provided UDL and database" {
        # Arrange
        $database = "Eulanda_PesterTest"

        # Act
        $result = Get-ConnStr -udl $udl -database $database

        # Assert
        $result | Should -Match "Provider=SQLOLEDB.1"
        $result | Should -Match "Initial Catalog=$database"
        $result | Should -Match "Persist Security Info=True"
        $result | Should -Match "User ID=eulanda"
    }

    It "Throws an exception when no database parameter is provided" {
        # Arrange
        Mock Get-ResStr { return "Missing database parameter" }

        # Act
        { Get-ConnStr -udl $udl } | Should -Throw
    }
}
