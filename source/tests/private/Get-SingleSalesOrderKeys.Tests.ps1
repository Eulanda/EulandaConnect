Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SingleSalesOrderKeys' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

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
