Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-UrlFragment' {
    InModuleScope EulandaConnect   {

        It 'Removes the hashtag at the start of the string' {
            $url = '#entwurf-die'
            $expected = ''
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Removes the hashtag at the end of the string and appends a slash' {
            $url = 'entwurf-die#'
            $expected = 'entwurf-die/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Returns the same string if there is no hashtag' {
            $url = 'entwurf-die'
            $expected = 'entwurf-die'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Removes hashtag that followes a special char' {
            $url = 'entwurf-die-b&#xE4;nd#er-3'
            $expected = 'entwurf-die-b&#xE4;nd/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Removes hashtag if special char followes' {
            $url = 'entwu#rf-die-b&#xE4;nder-3'
            $expected = 'entwu/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Handles special characters without valid hashtag' {
            $url = 'entwurf-die-b&#xE4;nder-3'
            $expected = 'entwurf-die-b&#xE4;nder-3'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Does not remove slash at the end of the string' {
            $url = 'entwurf/'
            $expected = 'entwurf/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Handles empty strings correctly' {
            $url = ''
            $expected = ''
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Handles single slash onl ycorrectly' {
            $url = '/'
            $expected = '/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }

        It 'Removes the hashtag fragment from the end of a full URL' {
            $url = 'https://eulandaconnect.eulanda.eu/docs/General/Imprint#impressum-deutsch'
            $expected = 'https://eulandaconnect.eulanda.eu/docs/General/Imprint/'
            $result = Remove-UrlFragment -url $url
            $result | Should -Be $expected
        }
    }
}
