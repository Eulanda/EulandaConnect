Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleArticleKeys' {
    # Use InModuleScope to access private functions
    InModuleScope 'EulandaConnect' {

        It 'should return correct keys' {
            # Act
            $result = Get-SingleArticleKeys

            # Assert
            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 4
            $result | Should -Contain 'articleId'
            $result | Should -Contain 'articleNo'
            $result | Should -Contain 'articleUid'
            $result | Should -Contain 'barcode'
        }
    }
}
