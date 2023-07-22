Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-LoremIpsum' {

    It "Returns at least minimum specified paragraphs" {
        $minParagraphs = 2
        $result = Get-LoremIpsum -minParagraphs $minParagraphs
        $paragraphCount = ([regex]::Matches($result, "`r`n")).Count + 1
        $paragraphCount | Should -BeGreaterOrEqual $minParagraphs
    }

    It "Does not exceed the maximum specified paragraphs" {
        $maxParagraphs = 5
        $result = Get-LoremIpsum -maxParagraphs $maxParagraphs
        $paragraphCount = ([regex]::Matches($result, "`r`n")).Count + 1
        $paragraphCount | Should -BeLessOrEqual $maxParagraphs
    }

    It "Should return between the specified min and max paragraphs" {
        $minParagraphs = 3
        $maxParagraphs = 7
        $result = Get-LoremIpsum -minParagraphs $minParagraphs -maxParagraphs $maxParagraphs
        $paragraphCount = ([regex]::Matches($result, "`r`n")).Count + 1
        $paragraphCount | Should -BeGreaterOrEqual $minParagraphs
        $paragraphCount | Should -BeLessOrEqual $maxParagraphs
    }
}
