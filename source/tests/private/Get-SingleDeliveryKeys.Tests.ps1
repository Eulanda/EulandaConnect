Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SingleDeliveryKeys' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should return correct array' {
            $result = Get-SingleDeliveryKeys

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'deliveryId'
            $result[1] | Should -Be 'deliveryNo'
        }
    }
}
