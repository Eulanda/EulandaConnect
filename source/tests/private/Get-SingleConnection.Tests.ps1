Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleConnection' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct array
        It 'should return correct array' {
            $result = Get-SingleConnection

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 3
            $result[0] | Should -Be 'conn'
            $result[1] | Should -Be 'connStr'
            $result[2] | Should -Be 'udl'
        }
    }
}
