Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleSalesOrderKeys' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct array
        It 'should return correct array' {
            $result = Get-SingleSalesOrderKeys

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 3
            $result | Should -Contain 'salesOrderId'
            $result | Should -Contain 'salesOrderNo'
            $result | Should -Contain 'customerOrderNo'
        }
    }
}
