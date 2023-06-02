Import-Module .\EulandaConnect.psd1

Describe "Get-Subnet" {
    It "returns the correct subnet mask for a CIDR value" {
        $result = Get-Subnet -cidr 24
        $result | Should -Be "255.255.255.0"
    }

    It "returns a subnet mask other than '0.0.0.0' when no parameters are provided" {
        $result = Get-Subnet
        $result | Should -Not -Be "0.0.0.0"
    }

    It "returns '0.0.0.0' when invalid CIDR is provided" {
        $result = Get-Subnet -cidr 999
        $result | Should -Be "0.0.0.0"
    }
}
