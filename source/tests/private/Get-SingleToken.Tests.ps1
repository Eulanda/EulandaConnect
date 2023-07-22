Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SingleToken' {
    InModuleScope EulandaConnect {

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
