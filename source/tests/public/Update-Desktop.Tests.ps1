Import-Module .\EulandaConnect.psd1

Describe 'Update-Desktop' {
    BeforeAll {
        #
    }

    It 'Runs without throwing an error' {
        { Update-Desktop } | Should -Not -Throw
    }
}
