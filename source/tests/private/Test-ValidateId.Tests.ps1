Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateId' {
    InModuleScope 'EulandaConnect' {
        It 'should throw an exception when the id is less than 1' {
            { Test-ValidateId -id 0 -name 'TestID' } | Should -Throw
        }

        It 'should not throw an exception when the id is greater than 1' {
            { Test-ValidateId -id 2 -name 'TestID' } | Should -Not -Throw
        }

        It 'should return the input id when it is valid' {
            $id = Test-ValidateId -id 3 -name 'TestID'
            $id | Should -Be 3
        }
    }
}
