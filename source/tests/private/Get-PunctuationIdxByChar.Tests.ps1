Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-PunctuationIdxByChar' {
    InModuleScope 'EulandaConnect' {

        # Test if the function returns correct index of punctuation
        It 'should return correct index of punctuation' {
            $result = Get-PunctuationIdxByChar -text 'Hello, world!' -match ','

            $result | Should -Be 6
        }

        # Test if the function returns -1 when no match is found
        It 'should return -1 when no match is found' {
            $result = Get-PunctuationIdxByChar -text 'Hello world' -match ','

            $result | Should -Be -1
        }

        # Test if the function returns correct index of space
        It 'should return correct index of space' {
            $result = Get-PunctuationIdxByChar -text 'Hello world' -match ' '

            $result | Should -Be 5
        }

        # Test if the function returns -1 when no space is found
        It 'should return -1 when no space is found' {
            $result = Get-PunctuationIdxByChar -text 'Helloworld' -match ' '

            $result | Should -Be -1
        }
    }
}
