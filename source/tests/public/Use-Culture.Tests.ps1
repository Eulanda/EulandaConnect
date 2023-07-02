Import-Module -Name .\EulandaConnect.psd1

Describe 'Use-Culture' {

    It 'Formats date in German correctly' {
        $result = Use-Culture -culture 'de-DE' -script { (Get-Date "2023-01-01").ToString("MMMM") }
        $expected = 'Januar'
        $result.ToLower() | Should -BeLike $expected.ToLower()
    }

    It 'Formats date in Italian correctly' {
        $result = Use-Culture -culture 'it-IT' -script { (Get-Date "2023-01-01").ToString("MMMM") }
        $expected = 'gennaio'
        $result.ToLower() | Should -BeLike $expected.ToLower()
    }

    It 'Formats date in English correctly' {
        $result = Use-Culture -culture 'en-US' -script { (Get-Date "2023-01-01").ToString("MMMM") }
        $expected = 'January'
        $result.ToLower() | Should -BeLike $expected.ToLower()
    }

    It 'Throws an error for invalid culture' {
        { Use-Culture -culture 'zz-' -script { return } } | Should -Throw
    }
}
