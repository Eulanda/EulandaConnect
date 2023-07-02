Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ResStr' {

    It "Returns a key in brackets with a preceding question mark when the key does not exist" {
        $result = Get-ResStr -key 'kjhlkjl'
        $result | Should -Be "?[kjhlkjl]"
    }

    Context "Language tests" {
        It "Returns an English string when the culture is set to English" {
            Out-Welcome -culture 'en-US' -noBanner -noInfo
            $result = Get-ResStr -key 'PATHIN_DOES_NOT_EXIST'
            $result | Should -Be "The file for the -pathIn '{0}' parameter does not exist!"
        }

        It "Returns a German string when the culture is set to German" {
            Out-Welcome -culture 'de-DE' -noBanner -noInfo
            $result = Get-ResStr -key 'PATHIN_DOES_NOT_EXIST'
            $result | Should -Be "Die Datei für den Parameter -pathIn '{0}' existiert nicht!"
        }

        It "Returns an English string when the culture is set to a language that is not supported" {
            Out-Welcome -culture 'es-ES' -noBanner -noInfo
            $result = Get-ResStr -key 'PATHIN_DOES_NOT_EXIST'
            $result | Should -Be "The file for the -pathIn '{0}' parameter does not exist!"
        }
    }
}
