Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SetStringCase' {
    InModuleScope EulandaConnect {

        It "returns the correct set of string cases" {
            $expectedCases = @('none', 'upper', 'lower', 'capital')
            $result = Get-SetStringCase

            $result | Should -Be $expectedCases
        }
    }
}
