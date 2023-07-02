Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DatanormPriceUnit' {
    InModuleScope 'EulandaConnect' {

        It 'Returns 1 for input 0' {
            Get-DatanormPriceUnit -priceUnitCode 0 | Should -Be 1
        }

        It 'Returns 10 for input 1' {
            Get-DatanormPriceUnit -priceUnitCode 1 | Should -Be 10
        }

        It 'Returns 100 for input 2' {
            Get-DatanormPriceUnit -priceUnitCode 2 | Should -Be 100
        }

        It 'Returns 1000 for input 3' {
            Get-DatanormPriceUnit -priceUnitCode 3 | Should -Be 1000
        }

        It 'Throws an exception for an invalid input' {
            { Get-DatanormPriceUnit -priceUnitCode 5 } | Should -Throw
        }
    }
}
