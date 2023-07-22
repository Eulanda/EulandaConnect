Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-TranslateExtractTag' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should return correct iso when no subtag is given' {
            # Arrange
            $inputValue = "[DE]"
            $expectedOutput = @("DE", "")

            # Act
            $result = Get-TranslateExtractTag -value $inputValue

            # Assert
            $result | Should -Be $expectedOutput
        }

        It 'should return correct iso and subtag when both are given' {
            # Arrange
            $inputValue = "[DE:TECHNIK]"
            $expectedOutput = @("DE", "TECHNIK")

            # Act
            $result = Get-TranslateExtractTag -value $inputValue

            # Assert
            $result | Should -Be $expectedOutput
        }
    }
}
