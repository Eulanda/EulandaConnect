Import-Module -Name .\EulandaConnect.psd1

Describe 'Out-Beep' {

    It 'Runs without throwing' {
        { Out-Beep } | Should -Not -Throw
    }
}
