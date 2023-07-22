Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-HtmlMetaData' -Tag 'eulanda' {

    It 'should return a hashtable with default values when no parameters are provided' {
        $metaData = Get-HtmlMetaData
        $metaData.author | Should -Be "EULANDA Software GmbH - ERP-Systems - Germany"
        $metaData.generator | Should -Be "Powershell $($PsVersiontable.GitCommitId) by function ConvertTo-Html"
        $metaData.keywords | Should -Be "eulanda, erp, powershell, convertto-html, html"
        $metaData.viewport | Should -Be "width=device-width, initial-scale=1.0"
        $metaData.ContainsKey('description') | Should -Be $false
    }

    It 'should include a description when provided as a parameter' {
        $description = 'My meta description'
        $metaData = Get-HtmlMetaData -description $description
        $metaData.description | Should -Be $description
    }
}
