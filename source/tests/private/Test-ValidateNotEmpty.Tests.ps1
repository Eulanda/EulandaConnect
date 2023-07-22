Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateNotEmpty' {
    InModuleScope EulandaConnect {

        It "Returns true when the parameter is not empty" {
            $result = Test-ValidateNotEmpty -strParam "not empty"
            $result | Should -BeTrue
        }

        It "Throws an error when the parameter is empty" {
            { Test-ValidateNotEmpty -strParam "" } | Should -Throw
        }
    }
}
