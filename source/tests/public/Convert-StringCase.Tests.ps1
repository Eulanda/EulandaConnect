Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Convert-StringCase' {

    It 'converts to uppercase' {
        Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase 'upper' | Should -Be 'DER CAFFÈ IST ÜBERGUT IN ÖSTERREICH!'
    }

    It 'converts to lowercase' {
        Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase 'lower' | Should -Be 'der caffè ist übergut in österreich!'
    }

    It 'converts to title case' {
        Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase 'capital' | Should -Be 'Der Caffè Ist Übergut In Österreich!'
    }

    It 'does not change the case when strCase is none' {
        Convert-StringCase -value 'Der Caffè ist übergut in Österreich!' -strCase 'none' | Should -Be 'Der Caffè ist übergut in Österreich!'
    }
}
