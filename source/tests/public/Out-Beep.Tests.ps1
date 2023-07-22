Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Out-Beep' {

    It 'Runs without throwing' {
        { Out-Beep } | Should -Not -Throw
    }
}
