Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-MappingArticleKeys' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct hash table
        It 'should return correct hash table' {
            $result = Get-MappingArticleKeys

            $result | Should -BeOfType [HashTable]
            $result.Count | Should -Be 4
            $result['articleId'] | Should -Be 'Id'
            $result['articleNo'] | Should -Be 'ArtNummer'
            $result['articleUid'] | Should -Be 'Uid'
            $result['Barcode'] | Should -Be 'Barcode'
        }
    }
}
