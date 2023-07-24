Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-MssqlAdministrator' -Tag 'integration', 'sql' {

    BeforeAll {
        $udl = '.\source\tests\Eulanda_1 Pester.udl'
    }

    It 'Should not throw' {
        { Test-MssqlAdministrator -udl $udl } | Should -Not -Throw
    }
}
