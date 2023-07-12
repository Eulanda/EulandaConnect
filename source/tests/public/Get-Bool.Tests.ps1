Import-Module -Name .\EulandaConnect.psd1

Describe "Testing Get-Bool" {
    Context "Positive Tests" {
        It "Should return $true for 1" {
            Get-Bool -boolStr '1' | Should -Be $true
        }

        It "Should return $true for 'TRUE'" {
            Get-Bool -boolStr 'TRUE' | Should -Be $true
        }

        It "Should return $true for '$TRUE'" {
            Get-Bool -boolStr "$TRUE" | Should -Be $true
        }

        It "Should return $true for ""$TRUE""" {
            Get-Bool -boolStr "$TRUE" | Should -Be $true
        }
    }

    Context "Negative Tests" {
        It "Should return $false for any other value" {
            Get-Bool -boolStr 'any other value' | Should -Be $false
        }
    }
}
