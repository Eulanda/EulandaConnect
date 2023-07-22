Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SingleAddressKeys' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should return correct keys' {
            # Act
            $result = Get-SingleAddressKeys

            # Assert
            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 3
            $result | Should -Contain 'addressId'
            $result | Should -Contain 'addressMatch'
            $result | Should -Contain 'addressUid'
        }
    }
}
