Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ReadOnlyFields' {
    # Use InModuleScope to access private functions
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            # Initialize a test connection, udl, or connStr
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $udl= Join-Path $pesterFolder 'Eulanda_1 Pester.udl'
            $testTableName = 'Artikel'
        }

        It 'should return an array of read-only fields for a given table' {
            # Act
            $result = Get-ReadOnlyFields -tableName $testTableName -udl $udl

            # Assert
            $result.GetType().Name | Should -Be 'Object[]'
            $result.Length | Should -BeGreaterThan 0
            $result | Should -Contain "ID"
        }
    }
}
