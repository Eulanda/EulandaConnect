Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DeliveryLink' {

    It "with default alias and deliveryId" {
        $result = Get-DeliveryLink -deliveryId 999
        $expected = "lf.Id = 999"
        $result | Should -Be $expected
    }

    It "with default alias and deliveryNo" {
        $result = Get-DeliveryLink -deliveryNo 20230522
        $expected = "lf.KopfNummer = 20230522"
        $result | Should -Be $expected
    }

    It "with order 'af' alias and deliveryId" {
        $result = Get-DeliveryLink -alias af -deliveryId 999
        $expected = "af.Id = 999"
        $result | Should -Be $expected
    }
}
