Import-Module -Name .\EulandaConnect.psd1

Describe 'ManifestContent' -Tag 'helper' {

    BeforeAll {
        $moduleName = 'EulandaConnect'
        $PathToManifest = Resolve-Path([System.IO.Path]::Combine($PSScriptRoot, '..', '..', '..', "$ModuleName.psd1"))
        if (Get-Module -Name $moduleName -ErrorAction 'SilentlyContinue') {
            Remove-Module -Name $moduleName -Force
        }
        Import-Module $PathToManifest -Force
        $manifestEval = Test-ModuleManifest -Path $PathToManifest
    }

    It "Manifest should have correct content" {
        $manifestEval.Name | Should -Be $moduleName -Because "Module name '$moduleName' don't match name in manifest"
        $manifestEval.Description | Should -Not -BeNullOrEmpty -Because "Description in manifest should not be empty"
        $manifestEval.Author | Should -Not -BeNullOrEmpty -Because "Author in manifest should not be empty"
        $manifestEval.Version | Should -Not -BeNullOrEmpty -Because "Version in manifest is empty or not a valid version number"
        $manifestEval.Guid | Should -Match '^[{(]?[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}[)}]?$' -Because "Guid in manifest is not valid"
        $manifestEval.Tags | ForEach-Object {
            $_ | Should -Not -Match " " -Because "Tags should not contain spaces"
        }
        $manifestEval.ProjectUri | Should -Not -BeNullOrEmpty -Because "ProjectUri in manifest should not be empty"
    }
}
