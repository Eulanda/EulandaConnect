Import-Module -Name .\EulandaConnect.psd1

Describe "Get-PropertySql" {
    It "Generates correct SQL for given breadcrumb path and tablename" {
        # Define parameters
        $breadcrumbPath = '\Shop'
        $tablename = 'Artikel' # test only german, the substitution is already tested

        # Invoke function
        $result = Get-PropertySql -breadcrumbPath $breadcrumbPath -tablename $tablename

        # Check that SQL contains the required elements
        $result | Should -Match "FROM Merkmal"
        $result | Should -Match "ID = @BreadcrumbID"
        $result | Should -Match "AND Tabelle = '$tablename'"
        $result | Should -Match "AND NOT Name LIKE '.%'"
        $result | Should -Match "ORDER BY ParentId, Sort, Name;"
    }
}

