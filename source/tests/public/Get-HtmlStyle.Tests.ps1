Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-HtmlStyle' {
    It 'should return the predefined CSS style' {
        $style = Get-HtmlStyle

        $style | Should -BeLike "*html {*"
        $style | Should -BeLike "*body {*"
        $style | Should -BeLike "*h1 {*"
        $style | Should -BeLike "*h2 {*"
        $style | Should -BeLike "*h3 {*"
        $style | Should -BeLike "*table {*"
        $style | Should -BeLike "*td {*"
        $style | Should -BeLike "*th {*"
        $style | Should -BeLike "*#CreationDate {*"
        $style | Should -BeLike "*.StatusAttention {*"
        $style | Should -BeLike "*.StatusNormal {*"
        $style | Should -BeLike "*</style>*"
    }
}
