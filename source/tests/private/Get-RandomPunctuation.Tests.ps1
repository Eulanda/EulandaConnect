Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-RandomPunctuation' {
    # Use InModuleScope to access private functions
    InModuleScope 'EulandaConnect' {
        It 'should return a punctuation string' {
            # Act
            $result = Get-RandomPunctuation

            # Assert
            $result | Should -BeOfType [String]
            $result | Should -BeIn @(".", "!", "?")
        }
    }
}
