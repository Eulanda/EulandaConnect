Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleToken' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct array
        It 'should return correct array' {
            $result = Get-SingleToken

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 4
            $result[0] | Should -Be 'token'
            $result[1] | Should -Be 'encryptedToken'
            $result[2] | Should -Be 'secureToken'
            $result[3] | Should -Be 'pathToToken'
        }
    }
}
