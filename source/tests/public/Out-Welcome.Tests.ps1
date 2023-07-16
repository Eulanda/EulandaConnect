Import-Module -Name .\EulandaConnect.psd1

Describe "Out-Welcome" {
    Context "Running Out-Welcome with Verbose" {
        It "Runs without throwing and outputs verbose messages correctly" {
            { Out-Welcome -culture 'en-US' -Verbose } | Should -Not -Throw
            $result = Out-Welcome -culture 'en-US' -Verbose 4>&1 | Out-String
            $result | Should -Match 'Version'
            $result | Should -Match 'EulandaConnect'
        }
    }
}
