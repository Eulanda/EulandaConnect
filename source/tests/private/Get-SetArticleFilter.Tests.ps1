Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SetArticleFilter' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct array
        It 'should return correct array' {
            $result = Get-SetArticleFilter

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 6
            $result[0] | Should -Be 'select'
            $result[1] | Should -Be 'filter'
            $result[2] | Should -Be 'order'
            $result[3] | Should -Be 'alias'
            $result[4] | Should -Be 'reorder'
            $result[5] | Should -Be 'revers'
        }
    }
}
