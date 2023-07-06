Import-Module -Name .\EulandaConnect.psd1

Describe "Test-OpenVPNInstalled" {
    InModuleScope 'EulandaConnect' {
        It "Should test the correct path" {
            Mock Test-Path { $true } -ParameterFilter { $Path -eq 'C:\Program Files\OpenVPN\bin\openvpn.exe' }
            Test-OpenVPNInstalled | Should -BeTrue
            Assert-MockCalled Test-Path -Times 1 -Scope It
        }

        It "Should return a boolean" {
            Mock Test-Path { $true }
            $result = Test-OpenVPNInstalled
            $result | Should -BeOfType [bool]
        }
    }
}
