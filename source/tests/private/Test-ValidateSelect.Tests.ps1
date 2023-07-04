Import-Module -Name .\EulandaConnect.psd1

Describe "Test-ValidateSelect" {
    InModuleScope 'EulandaConnect' {

        It "Should throw an exception" {
            { Test-ValidateSelect -strParam "" } | Should -Throw
        }


        It "Should return $true" {
            $result = Test-ValidateSelect -strParam "some value"
            $result | Should -Be $true
        }

    }
}
