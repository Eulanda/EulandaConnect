Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-ValidateStringCase' {
    InModuleScope EulandaConnect {

        $testCases = @(
            @{ Value = "none"; IsValid = $true },
            @{ Value = "upper"; IsValid = $true },
            @{ Value = "lower"; IsValid = $true },
            @{ Value = "capital"; IsValid = $true },

            @{ Value = "invalid"; IsValid = $false }
        )

        It "validates string case '<Value>' correctly" -TestCases $testCases {
            param ($Value, $IsValid)

            if ($IsValid) {
                { Test-ValidateStringCase -value $Value } | Should -Not -Throw
            } else {
                { Test-ValidateStringCase -value $Value } | Should -Throw
            }
        }
    }
}
