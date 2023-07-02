Import-Module -Name .\EulandaConnect.psd1

Describe 'Update-Desktop' {

    It 'Runs without throwing an error' {
        { Update-Desktop } | Should -Not -Throw
    }
}
