Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'ConvertTo-USFloat' {

    It "Converts European style float string to US style" {
        $inputString = "2.561,12"
        $expectedOutput = "2561.12"
        ConvertTo-USFloat -inputString $inputString | Should -Be $expectedOutput
    }

    It "Converts US style float string to US style" {
        $inputString = "2,561.12"
        $expectedOutput = "2561.12"
        ConvertTo-USFloat -inputString $inputString | Should -Be $expectedOutput
    }

    It "Keeps already US style float string unchanged" {
        $inputString = "2561.12"
        $expectedOutput = "2561.12"
        ConvertTo-USFloat -inputString $inputString | Should -Be $expectedOutput
    }

    It "Throws an error if the input string contains non-numeric characters" {
        $inputString = "25a61.12"
        { ConvertTo-USFloat -inputString $inputString } | Should -Throw
    }
}
