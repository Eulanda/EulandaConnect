Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-SpecificParameters' {
    InModuleScope EulandaConnect {

        Context "When at least one specific parameter is passed" {
            It "Should not throw any error" {
                { Test-SpecificParameters -BoundParameters @{administrator = $true} -CommandName 'Confirm-System' } | Should -Not -Throw
            }
        }

        Context "When no specific parameters are passed" {
            It "Should throw an error" {
                { Test-SpecificParameters -BoundParameters @{Verbose = $true} -CommandName 'Confirm-System' } | Should -Throw
            }
        }

        Context "When invalid CommandName is passed" {
            It "Should throw an error" {
                { Test-SpecificParameters -BoundParameters @{administrator = $true} -CommandName 'NonExistingCommand' } | Should -Throw
            }
        }
    }
}
