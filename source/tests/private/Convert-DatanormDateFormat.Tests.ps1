Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Convert-DatanormDateFormat' {
    InModuleScope EulandaConnect {

        It 'converts Datanorm date format to ISO 8601 format correctly' {
            # Arrange
            $datanormDate = '310122'
            $expectedISODate = '2022-01-31'

            # Act
            $actualISODate = Convert-DatanormDateFormat -date $datanormDate

            # Assert
            $actualISODate | Should -Be $expectedISODate
        }

        It 'throws an exception for an invalid Datanorm date format' {
            # Arrange
            $invalidDatanormDate = 'invalid-date'

            # Act and Assert
            { Convert-DatanormDateFormat -date $invalidDatanormDate } | Should -Throw
        }
    }
}
