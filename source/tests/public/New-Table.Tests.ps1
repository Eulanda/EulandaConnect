Import-Module -Name .\EulandaConnect.psd1

Describe 'New-Table' {

    BeforeAll {
        $global:tableName = "MyTable"
        $global:columnNames = "Name,Value/?Int"
    }

    It 'New-Table creates a table' {
        New-Table -tableName $global:tableName -columnNames $global:columnNames

        # Check if table was created
        $tableExists = Test-Path variable:global:$global:tableName
        $tableExists | Should -BeTrue

        # If table was created, check its columns
        if ($tableExists) {
            $table = Get-Variable -Name $global:tableName -Scope Global -ValueOnly

            $table.Columns.Count | Should -Be 2

            $table.Columns[0].ColumnName | Should -Be "Name"
            $table.Columns[0].DataType.Name | Should -Be "String"

            $table.Columns[1].ColumnName | Should -Be "Value"
            $table.Columns[1].DataType.Name | Should -Be "Int32"
        }
    }

    AfterAll {
        # Clean up the created table
        if (Test-Path variable:global:$global:tableName) {
            Remove-Variable -Name $global:tableName -Scope Global
        }
    }
}
