Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Convert-ToDecimalDegrees' {

    It "Converts degrees, minutes, and seconds to decimal format" {
        # Arrange
        $degrees = 40
        $minutes = 20
        $seconds = 30
        $direction = 'N'

        # Act
        $result = Convert-ToDecimalDegrees -degrees $degrees -minutes $minutes -seconds $seconds -direction $direction

        # Assert
        $expectedResult = $degrees + ($minutes / 60) + ($seconds / 3600)
        $result | Should -Be $expectedResult
    }

    It "Returns a negative result for S or W direction" {
        # Arrange
        $degrees = 40
        $minutes = 20
        $seconds = 30
        $direction = 'W'

        # Act
        $result = Convert-ToDecimalDegrees -degrees $degrees -minutes $minutes -seconds $seconds -direction $direction

        # Assert
        $expectedResult = -($degrees + ($minutes / 60) + ($seconds / 3600))
        $result | Should -Be $expectedResult
    }
}
