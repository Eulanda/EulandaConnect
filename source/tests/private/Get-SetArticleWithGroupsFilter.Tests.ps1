Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SetArticleWithGroupsFilter' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should return correct array' {
            $result = Get-SetArticleWithGroupsFilter

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 7
            $result[0] | Should -Be 'select'
            $result[1] | Should -Be 'filter'
            $result[2] | Should -Be 'order'
            $result[3] | Should -Be 'alias'
            $result[4] | Should -Be 'reorder'
            $result[5] | Should -Be 'revers'
            $result[6] | Should -Be 'customerGroups'
        }
    }
}
