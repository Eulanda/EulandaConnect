Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DatanormCuSurcharge' {
    InModuleScope 'EulandaConnect' {
        It 'should calculate the copper surcharge correctly' {
            $result = Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 879 -cuIncluded 150
            $expected = 0.18225
            $tolerance = $expected * 0.001  # 0.1% of the expected value
            [Math]::Abs($result - $expected) | Should -BeLessThan $tolerance
        }

        It 'should return 0 when cuWeight is 0' {
            $result = Get-DatanormCuSurcharge -cuWeight 0 -divisionCode 1 -cuDel 879 -cuIncluded 150
            $result | Should -Be 0
        }

        It 'should return 0 when cuDel is less than cuIncluded' {
            $result = Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 1 -cuDel 100 -cuIncluded 150
            $result | Should -Be 0
        }

        It 'should return correct surcharge when divisionCode is 2' {
            $result = Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 2 -cuDel 879 -cuIncluded 150
            $expected = 0.018225
            $tolerance = $expected * 0.001  # 0.1% of the expected value
            [Math]::Abs($result - $expected) | Should -BeLessThan $tolerance
        }

        It 'should throw an error when divisionCode is not 0, 1, or 2' {
            { Get-DatanormCuSurcharge -cuWeight 2.5 -divisionCode 3 -cuDel 879 -cuIncluded 150 } | Should -Throw
        }
    }
}
