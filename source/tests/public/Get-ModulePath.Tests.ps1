Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ModulePath' {

    It 'Should return the path of the default module EulandaConnect when no module name is provided' {
        $modulePath = Get-ModulePath
        $modulePath | Should -Be (Get-Module -Name 'EulandaConnect').ModuleBase
    }


    It 'Should return the path of the specified module when a module name is provided' {
        $modulePath = Get-ModulePath -module 'Pester'
        $modulePath | Should -Be (Get-Module -Name 'Pester').ModuleBase
    }


    It 'Should throw an exception when a non-existent module is provided' {
        { Get-ModulePath -module 'NonExistentModule' } | Should -Throw
    }
}
