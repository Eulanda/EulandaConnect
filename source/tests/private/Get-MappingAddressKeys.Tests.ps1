Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-MappingAddressKeys' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        # Test if the function returns correct hash table
        It 'should return correct hash table' {
            $result = Get-MappingAddressKeys

            $result | Should -BeOfType [HashTable]
            $result.Count | Should -Be 3
            $result['addressId'] | Should -Be 'Id'
            $result['addressMatch'] | Should -Be 'Match'
            $result['addressUid'] | Should -Be 'Uid'
        }
    }
}
