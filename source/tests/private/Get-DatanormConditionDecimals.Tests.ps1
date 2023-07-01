Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DatanormConditionDecimals' {
    InModuleScope 'EulandaConnect' {
        It 'should return correct decimals for indicator 0' {
            $result = Get-DatanormConditionDecimals -condition '10000' -indicator 0
            $result | Should -Be '10000'
        }

        It 'should return correct decimals for indicator 1' {
            $result = Get-DatanormConditionDecimals -condition '10000' -indicator 1
            $result | Should -Be '100,00'
        }

        It 'should return correct decimals for indicator 2' {
            $result = Get-DatanormConditionDecimals -condition '10000' -indicator 2
            $result | Should -Be '10,000'
        }

        It 'should return correct decimals for indicator 3' {
            $result = Get-DatanormConditionDecimals -condition '10000' -indicator 3
            $result | Should -Be '100,00'
        }

        It 'should throw exception for invalid indicator' {
            { Get-DatanormConditionDecimals -condition '10000' -indicator 5 } | Should -Throw
        }
    }
}
