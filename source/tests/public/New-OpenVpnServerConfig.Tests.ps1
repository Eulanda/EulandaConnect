Import-Module -Name .\EulandaConnect.psd1

Describe 'New-OpenVpnServerConfig' -Tag 'integration', 'openvpn' {

    BeforeAll {
        $openVpnPath = "$($env:ProgramFiles)\OpenVPN"
        $destination = Join-Path -Path "$($home)\.eulandaconnect\OpenVPN" -ChildPath "Pester"
        $hostname = [System.Net.Dns]::GetHostName()
        $networkAddress = '192.168.40.0'
        $configPath = Join-Path -path $destination "server\$hostname.ovpn"
    }

    It "should create an ovpn file at the destination path" {
        New-OpenVpnServerConfig -openVpnPath $openVpnPath -destination $destination -hostname $hostname -networkAddress $networkAddress

        # Verify that the file exists
        Test-Path $configPath | Should -BeTrue
    }

    It "should contain the hostname and network address in the ovpn file" {
        $configContent = Get-Content -Path $configPath -Raw

        # Verify that the content includes hostname and network address
        $configContent | Should -Match $hostname
        $configContent | Should -Match $networkAddress
    }

    AfterAll {
        # Delete the test files and directory
        Remove-Item -Path $destination -Force -Recurse -ErrorAction SilentlyContinue
    }

}
