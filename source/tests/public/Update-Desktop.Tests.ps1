Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Update-Desktop' {

    It 'Runs without throwing an error' {
        { Update-Desktop } | Should -Not -Throw
    }
}
