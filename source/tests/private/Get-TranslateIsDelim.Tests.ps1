Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-TranslateIsDelim' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should return $true for a valid ISO tag without subtag' {
            # Arrange
            $inputValue = "[DE]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $true
        }

        It 'should return $true for a valid ISO tag with subtag' {
            # Arrange
            $inputValue = "[DE:TECHNIK]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $true
        }

        It 'should return $true for a tag applicable to all undefined languages' {
            # Arrange
            $inputValue = "[:TECHNIK]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $true
        }

        It 'should return $false for an invalid ISO tag' {
            # Arrange
            $inputValue = "[D]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }

        It 'should return $false for an invalid ISO tag with misplaced colon' {
            # Arrange
            $inputValue = "[D:TECHNIK]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }

        It 'should return $false for an invalid language tag line' {
            # Arrange
            $inputValue = "xy [DE]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }

        It 'should return $false for round brackets' {
            # Arrange
            $inputValue = "(DE)"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }

        It 'should return $false not closing bracket' {
            # Arrange
            $inputValue = "[DE"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }

        It 'should return $false not opening bracket' {
            # Arrange
            $inputValue = "DE]"

            # Act
            $result = Get-TranslateIsDelim -value $inputValue

            # Assert
            $result | Should -Be $false
        }
    }
}
