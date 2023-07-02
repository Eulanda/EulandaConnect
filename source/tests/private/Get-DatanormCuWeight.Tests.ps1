Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DatanormCuWeight' {
    InModuleScope 'EulandaConnect' {

        It "Returns 0 if divisionCode is 0" {
            $result = Get-DatanormCuWeight -divisionCode 0 -cuWeight 2.5
            $result | Should -Be 0
        }

        It "Returns correct weight per unit for divisionCode 1" {
            $result = Get-DatanormCuWeight -divisionCode 1 -cuWeight 2.5
            $result | Should -Be 0.025
        }

        It "Returns correct weight per unit for divisionCode 2" {
            $result = Get-DatanormCuWeight -divisionCode 2 -cuWeight 2.5
            $result | Should -Be 0.0025
        }

        It "Returns 0 if copper weight is 0" {
            $result = Get-DatanormCuWeight -divisionCode 1 -cuWeight 0
            $result | Should -Be 0
        }

        It "Throws an exception for invalid divisionCode" {
            { Get-DatanormCuWeight -divisionCode 3 -cuWeight 2.5 } | Should -Throw
        }
    }
}
