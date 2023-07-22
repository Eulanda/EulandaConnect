Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DeliverySql' -Tag 'eulanda' {

    Context "With deliveryId and deliveryNo parameters" {
        It "Should return an array of SQL queries" {
            # Arrange
            $deliveryNo = 5678

            # Act
            $result = Get-DeliverySql -deliveryNo $deliveryNo

            # Assert
            $result | Should -Not -BeNullOrEmpty
            $result.Count | Should -Be 2
            $result[0] | Should -Match "SELECT"
            $result[1] | Should -Match "SELECT"
        }
    }

    Context "Without parameters" {
        It "Should throw an error" {
            { Get-DeliverySql } | Should -Throw
        }
    }

}
