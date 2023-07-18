Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleAddressKeys' {
    # Use InModuleScope to access private functions
    InModuleScope 'EulandaConnect' {

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
