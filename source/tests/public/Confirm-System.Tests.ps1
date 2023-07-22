Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Confirm-System' {

    It 'Runs without throwing with valid parameters' {
        { Confirm-System -all } | Should -Not -Throw
    }

    It 'Runs with throwing without parameters' {
        { Confirm-System  } | Should -Throw
    }
}
