Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DatanormPricePerUnit' {
    InModuleScope 'EulandaConnect' {

        It 'Returns correct price for input price 10 and priceUnitCode 0' {
            $actual = Get-DatanormPricePerUnit -price 10 -priceUnitCode 0
            $expected = 10
            $tolerance = $expected * 0.001
            [Math]::Abs($actual - $expected) | Should -BeLessThan $tolerance
        }

        It 'Returns smaller price for input price 10 and priceUnitCode 1' {
            $actual = Get-DatanormPricePerUnit -price 10 -priceUnitCode 1
            $expected = 1
            $tolerance = $expected * 0.001
            [Math]::Abs($actual - $expected) | Should -BeLessThan $tolerance
        }

        It 'Returns smaller price for input price 10 and priceUnitCode 2' {
            $actual = Get-DatanormPricePerUnit -price 10 -priceUnitCode 2
            $expected = 0.1
            $tolerance = $expected * 0.001
            [Math]::Abs($actual - $expected) | Should -BeLessThan $tolerance
        }

        It 'Returns smaller price for input price 10 and priceUnitCode 3' {
            $actual = Get-DatanormPricePerUnit -price 10 -priceUnitCode 3
            $expected = 0.01
            $tolerance = $expected * 0.001
            [Math]::Abs($actual - $expected) | Should -BeLessThan $tolerance
        }

        It 'Returns zero for input price 0' {
            0..3 | ForEach-Object {
                $actual = Get-DatanormPricePerUnit -price 0 -priceUnitCode $_
                $actual | Should -Be 0
            }
        }

        It 'Throws an exception for an invalid priceUnitCode' {
            { Get-DatanormPricePerUnit -price 10 -priceUnitCode 5 } | Should -Throw
        }
    }
}
