Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'HelpSystemContent' -Tag 'helper' {

    BeforeAll {
        $ModuleName = 'EulandaConnect'
        $PathToManifest = Resolve-Path([System.IO.Path]::Combine($PSScriptRoot, '..', '..', '..', "$ModuleName.psd1"))
        if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
            Remove-Module -Name $ModuleName -Force
        }
        Import-Module $PathToManifest -Force
        $moduleExported = Get-Command -Module $ModuleName | Select-Object -ExpandProperty Name
    }

    It "Commands should have proper help content" {
        foreach ($command in $moduleExported) {
            $help = Get-Help -Name $command -Full
            $help.Synopsis | Should -Not -BeNullOrEmpty -Because "$command should have a synopsis"
            $help.description.Text | Should -Not -BeNullOrEmpty -Because "$command should have a description"
            $help.examples.example | Should -Not -BeNullOrEmpty -Because "$command should have an example"
        }
    }
}
