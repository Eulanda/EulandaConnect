Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-SingleDeliveryKeys' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct array
        It 'should return correct array' {
            $result = Get-SingleDeliveryKeys

            $result.GetType().Name | Should -Be 'Object[]'
            $result.Count | Should -Be 2
            $result[0] | Should -Be 'deliveryId'
            $result[1] | Should -Be 'deliveryNo'
        }
    }
}
