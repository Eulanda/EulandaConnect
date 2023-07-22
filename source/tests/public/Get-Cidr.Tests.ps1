Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-Cidr' {

    Context 'when provided subnet is 255.255.255.0' {
        It 'returns 24' {
            Get-Cidr -subnet '255.255.255.0' | Should -Be 24
        }
    }

    Context 'when no parameters are provided' {
        It 'returns a valid CIDR notation' {
            Get-Cidr | Should -BeGreaterThan 0
        }
    }

    Context 'when a locally bound IP address is specified' {
        It 'returns a valid CIDR notation' {
            $localIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ne "Loopback Pseudo-Interface 1" }).IPAddress[0]
            Get-Cidr -ip $localIP | Should -BeGreaterThan 0
        }
    }
}
