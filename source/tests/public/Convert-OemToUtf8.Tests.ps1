Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-OemToUtf8' {

    It "Converts OEM-encoded string to UTF-8 string" {
        $inputString = "R" + [char]129 + "ckfahrt"
        $expectedOutput = "Rückfahrt"
        Convert-OemToUtf8 -inputString $inputString | Should -Be $expectedOutput
    }

    It "Keeps regular UTF-8 strings unchanged" {
        $inputString = "Regular string"
        $expectedOutput = "Regular string"
        Convert-OemToUtf8 -inputString $inputString | Should -Be $expectedOutput
    }

    It "Converts OEM-encoded string with multiple special characters to UTF-8 string" {
        $inputString = "A" + [char]132 + "B" + [char]148 + "C" + [char]129 + "D" + [char]142 + "E" + [char]153 + "F" + [char]154 + "G" + [char]225
        $expectedOutput = "AäBöCüDÄEÖFÜGß"
        Convert-OemToUtf8 -inputString $inputString | Should -Be $expectedOutput
    }
}
