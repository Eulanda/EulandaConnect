Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-RandomParagraph' {
    InModuleScope EulandaConnect {

        Context 'when generating a paragraph' {

            It 'should return a string with a sentence count within the specified range' {
                # Arrange
                $minSentences = 2
                $maxSentences = 4

                # Act
                $result = Get-RandomParagraph -minSentences $minSentences -maxSentences $maxSentences

                # Count the sentences in the result (assuming sentences are separated by punctuation followed by a space)
                $sentenceCount = ([regex]::Matches($result, '[.!?] ')).Count + 1

                # Assert
                $sentenceCount | Should -BeGreaterOrEqual $minSentences
                $sentenceCount | Should -BeLessOrEqual $maxSentences
            }
        }
    }
}
