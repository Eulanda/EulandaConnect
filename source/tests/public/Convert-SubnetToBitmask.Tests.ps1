Import-Module -Name .\EulandaConnect.psd1

Describe "Convert-SubnetToBitmask" {
    It "returns expected output for known input" {
        $result = Convert-SubnetToBitmask -cidr 24
        $expected = '11111111111111111111111100000000'
        $result | Should -Be $expected
    }

    It "returns 32x 0" {
        $result = Convert-SubnetToBitmask -cidr 0
        $expected = '00000000000000000000000000000000'
        $result | Should -Be $expected
    }

    It "returns 32x 1" {
        $result = Convert-SubnetToBitmask -cidr 32
        $expected = '11111111111111111111111111111111'
        $result | Should -Be $expected
    }

    It "throws when given invalid input" {
        { Convert-SubnetToBitmask -cidr 999 } | Should -Throw
    }

    It "throw when no input is provided" {
        { Convert-SubnetToBitmask } | Should -Throw
    }

}
