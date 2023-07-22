Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-RandomPunctuation' {
    InModuleScope EulandaConnect {

        It 'should return a punctuation string' {
            # Act
            $result = Get-RandomPunctuation

            # Assert
            $result | Should -BeOfType [String]
            $result | Should -BeIn @(".", "!", "?")
        }
    }
}
