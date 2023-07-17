Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-MappingSalesOrderKeys' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct hash table
        It 'should return correct hash table' {
            $result = Get-MappingSalesOrderKeys

            $result | Should -BeOfType [HashTable]
            $result.Count | Should -Be 3
            $result['salesOrderId'] | Should -Be 'Id'
            $result['salesOrderNo'] | Should -Be 'KopfNummer'
            $result['customerOrderNo'] | Should -Be 'Bestellnummer'
        }
    }
}
