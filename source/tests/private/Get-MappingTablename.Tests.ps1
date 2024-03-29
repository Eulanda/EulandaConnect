Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-MappingTablename' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        # Test if the function returns correct hash table
        It 'should return correct hash table' {
            $result = Get-MappingTablename

            $result | Should -BeOfType [HashTable]
            $result.Count | Should -Be 3
            $result['article'] | Should -Be 'artikel'
            $result['address'] | Should -Be 'adresse'
            $result['delivery'] | Should -Be 'lieferschein'
        }
    }
}
