Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateCustomerGroups' {
    InModuleScope EulandaConnect {

        # Test with valid input
        It 'Should not throw an exception with valid customerGroups' {
            $validCustomerGroups = "Group1,Group2,Group 3"
            { Test-ValidateCustomerGroups -customerGroups $validCustomerGroups } | Should -Not -Throw
        }

        # Test with invalid input
        It 'Should throw an exception with invalid customerGroups' {
            $invalidCustomerGroups = "Group1,Group2,Group#3"
            { Test-ValidateCustomerGroups -customerGroups $invalidCustomerGroups } | Should -Throw
        }

        # Test with empty string
        It 'Should not throw an exception with an empty string' {
            $emptyCustomerGroups = ""
            { Test-ValidateCustomerGroups -customerGroups $emptyCustomerGroups } | Should -Not -Throw
        }

        # Test with null
        It 'Should not throw an exception with null' {
            $nullCustomerGroups = $null
            { Test-ValidateCustomerGroups -customerGroups $nullCustomerGroups } | Should -Not -Throw
        }
    }
}
