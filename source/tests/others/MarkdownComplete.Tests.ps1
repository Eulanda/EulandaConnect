Import-Module .\EulandaConnect.psd1

Describe "MarkdownComplete" {
    It "Should not contain curly braces in markdown files" {
        $PathToMarkDown = Resolve-Path([System.IO.Path]::Combine($psScriptRoot, '..', '..', '..', 'docs', 'functions'))
        $files = (Get-ChildItem -Path $PathToMarkdown -Recurse -Include *.md | Select-String -Pattern "{{")

        $files | Should -BeNullOrEmpty
    }
}
