Import-Module -Name .\EulandaConnect.psd1

Describe 'New-OpenVpnTls' -Tag 'integration', 'openvpn' {
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            $openVpnPath = "$($env:ProgramFiles)\OpenVPN"
            $testDestination = "$($home)\.eulandaconnect\OpenVPN\pester"
            $keyPath = Join-Path -Path $testDestination -ChildPath "tls\ta.key"

            if (Test-Path $testDestination) {
                Remove-Item $testDestination -Recurse -Force
            }
        }

        It 'should find the openvpn.exe' {
            (Test-Path (Join-Path -Path $openVpnPath -ChildPath 'bin\openvpn.exe')) | Should -BeTrue
        }

        It 'should generate the key if it does not exist' {
            New-OpenVpnTls -openVpnPath $openVpnPath -destination $testDestination

            # Verify that the destination directory and the key file have been created
            (Test-Path $testDestination) | Should -BeTrue
            (Test-Path $keyPath) | Should -BeTrue
        }

        It 'should contain correct BEGIN END content' {
            New-OpenVpnTls -openVpnPath $openVpnPath -destination $testDestination

            # Verify that the key file contains expected content
            $keyContent = Get-Content $keyPath -Raw
            $keyContent | Should -Match 'BEGIN OpenVPN Static key V1'
            $keyContent | Should -Match 'END OpenVPN Static key V1'
        }

        It 'should contain correct bit content' {
            New-OpenVpnTls -openVpnPath $openVpnPath -destination $testDestination

            # Verify that the key file contains expected content
            $keyContent = Get-Content $keyPath -Raw
            $keyContent | Should -Match '2048 bit OpenVPN static key'
        }


        AfterAll {
            if (Test-Path $testDestination) {
                # Remove-Item $testDestination -Recurse -Force
            }

            if ((Test-Path $path) -and ((Get-ChildItem $path | Measure-Object).Count -eq 0)) {
               # [System.IO.Directory]::Delete($path)
            }

        }
    }
}
