Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'ConvertTo-WrappedLines' {

    It 'should correctly wrap a single line shorter than the width' {
        $result = ConvertTo-WrappedLines -text 'Hello, world!' -width 20
        $result.Count | Should -Be 1
        $result[0] | Should -Be 'Hello, world!'
    }

    It 'should correctly wrap a single line longer than the width' {
        $result = ConvertTo-WrappedLines -text 'Hello, world! This is a longer line that needs to be wrapped.' -width 20
        $result.Count | Should -Be 4
        $result[0] | Should -Be 'Hello, world! This'
        $result[1] | Should -Be 'is a longer line'
        $result[2] | Should -Be 'that needs to be'
        $result[3] | Should -Be 'wrapped.'
    }

    It 'should correctly wrap multiple lines' {
        $result = ConvertTo-WrappedLines -text "Hello, world!`nThis is another line." -width 20
        $result.Count | Should -Be 3
        $result[0] | Should -Be 'Hello, world!'
        $result[1] | Should -Be 'This is another'
        $result[2] | Should -Be 'line.'
    }

    It 'should correctly convert to string with specified line breaks' {
        $result = ConvertTo-WrappedLines -text 'Hello, world!' -width 20 -asString -useCrLf
        $result | Should -Be 'Hello, world!' -Because 'The input text is shorter than the width and should not be wrapped'
        $result = ConvertTo-WrappedLines -text 'Hello, world! This is a longer line that needs to be wrapped.' -width 20 -asString -useCrLf
        $result | Should -Be "Hello, world! This`r`nis a longer line`r`nthat needs to be`r`nwrapped."
    }

    It 'should correctly handle empty input' {
        $result = ConvertTo-WrappedLines -text '' -width 20
        $result.Count | Should -Be 1
        $result[0]  | Should -BeNullOrEmpty
    }

    It 'should correctly handle very long words' {
        $result = ConvertTo-WrappedLines -text 'thisisaverylongwordthatneedstobewrapped' -width 10
        $result.Count | Should -Be 4
        $result[0] | Should -Be 'thisisaver'
        $result[1] | Should -Be 'ylongwordt'
        $result[2] | Should -Be 'hatneedsto'
        $result[3] | Should -Be 'bewrapped'
    }
}
