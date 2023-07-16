Import-Module -Name .\EulandaConnect.psd1

Describe 'Out-Goodbye' {
    It 'outputs normally message when -normally switch is used' {
        $expectedMessage = Get-ResStr 'OUT_GOODBYE_NORMALLY'
        $result = Out-Goodbye -normally -Verbose 4>&1 | Out-String
        $result | Should -Match $expectedMessage
    }

    It 'outputs abnormally message when -abnormally switch is used' {
        $expectedMessage = Get-ResStr 'OUT_GOODBYE_ABNORMALLY'
        $result = Out-Goodbye -abnormally -Verbose 4>&1 | Out-String
        $result | Should -Match $expectedMessage
    }
}
