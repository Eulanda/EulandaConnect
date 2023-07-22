Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateNo' {
    InModuleScope EulandaConnect {

        It "Returns the transaction number when it is valid" {
            $result = Test-ValidateNo -transactionNo 1234 -name "Transaction Number"
            $result | Should -Be 1234
        }

        It "Throws an error when the transaction number is less than 1" {
            { Test-ValidateNo -transactionNo 0 -name "Transaction Number" } | Should -Throw
        }

        It "Throws an error when the transaction number is negative" {
            { Test-ValidateNo -transactionNo -1 -name "Transaction Number" } | Should -Throw
        }
    }
}
