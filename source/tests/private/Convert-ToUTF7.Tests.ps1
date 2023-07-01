Import-Module -Name .\EulandaConnect.psd1

Describe "Convert-ToUTF7" {
    InModuleScope 'EulandaConnect' {
        It "should convert string to UTF7 and back to UTF8" {
            $inputString = "ä"
            $utf7Result = Convert-ToUTF7 -value $inputString
            $utf8 = [System.Text.Encoding]::UTF8
            $utf7 = [System.Text.Encoding]::UTF7
            $bytes = $utf7.GetBytes($utf7Result)
            $utf8Bytes = [System.Text.Encoding]::Convert($utf7, $utf8, $bytes)
            $backToUtf8 = $utf8.GetString($utf8Bytes)
            $backToUtf8 | Should -Be $inputString
        }
    }
}

