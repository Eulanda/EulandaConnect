Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DefaultSelectArticle' -Tag 'eulanda' {
    InModuleScope EulandaConnect {

        It 'should always contain unique key string "ARTNUMMER"' {
            $result = Get-DefaultSelectArticle
            $result -match 'ARTNUMMER' | Should -Be $true
        }

        It 'should only contain uppercase' {
            $result = Get-DefaultSelectArticle
            $result.ToUpper() | Should -Be $result
        }

        It 'should be a comma-separated list' {
            $result = Get-DefaultSelectArticle
            $result -match '^([^,]+,)*[^,]+$' | Should -Be $true
        }

        It 'should not end with a comma' {
            $result = Get-DefaultSelectArticle
            $result -match '[^,]$' | Should -Be $true
        }

        It 'none of the comma-separated words should contain spaces, except after the comma' {
            $result = Get-DefaultSelectArticle
            $result -match '^([^ ,]+, )*[^ ,]+$' | Should -Be $true
        }

        It 'should only contain letters A-Z spaces or commas' {
            $result = Get-DefaultSelectArticle
            (Convert-Accent -value $result -strcase 'upper') | Should -Be $result
        }

    }
}
