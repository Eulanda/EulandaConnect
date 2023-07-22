Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-HtmlEncoded' {

    It 'should return untagged strings unchanged' {
        $string = 'This is a string without any tags.'
        $encodedString = Get-HtmlEncoded -taggedString $string
        $encodedString | Should -Be $string
    }

    It 'should correctly encode and restore recognized tags' {
        $string = 'This is <b>bold</b> and this is <strong>strong</strong>.'
        $expectedResult = 'This is <b>bold</b> and this is <strong>strong</strong>.'
        $encodedString = Get-HtmlEncoded -taggedString $string
        $encodedString | Should -Be $expectedResult
    }

    It 'should replace unrecognized tags with HTML encoded versions' {
        $string = 'This is <tag>not recognized</tag>.'
        $expectedResult = 'This is &lt;tag&gt;not recognized&lt;/tag&gt;.'
        $encodedString = Get-HtmlEncoded -taggedString $string
        $encodedString | Should -Be $expectedResult
    }
}
