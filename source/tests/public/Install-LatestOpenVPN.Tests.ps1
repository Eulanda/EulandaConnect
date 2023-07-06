Import-Module -Name .\EulandaConnect.psd1

Describe "Install-LatestOpenVPN" {
    InModuleScope 'EulandaConnect' {
        BeforeAll {
            $downloadPath = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath ([System.IO.Path]::GetRandomFileName())
            New-Item -Path $downloadPath -ItemType Directory | Out-Null
            $openVpnMsi = Join-Path -Path $downloadPath -ChildPath "OpenVPN.msi"
            New-Item -Path $openVpnMsi -ItemType File | Out-Null
        }

        AfterAll {
            Remove-Item -Path $downloadPath -Force -Recurse
        }

        Context "Get-LatestOpenVPNVersion" {
            It "Should return a version string" {
                $version = Get-LatestOpenVPNVersion
                $version | Should -Match "\d+\.\d+\.\d+"
            }
        }

        Context "Test-OpenVPNInstalled " {
            It "Should return a boolean" {
                $result = Test-OpenVPNInstalled
                $result | Should -BeOfType [bool]
            }
        }

        Context "Install-LatestOpenVPN function" {
            It "Should download the OpenVPN installer if not given a path" {
                Mock Invoke-WebRequest {} -Verifiable
                Mock Get-LatestOpenVPNVersion { return "2.5.0" }
                Install-LatestOpenVPN -downloadPath $downloadPath
                Assert-MockCalled Invoke-WebRequest -Times 1 -Scope It
            }

            It "Should not download the OpenVPN installer if given a valid path" {
                Mock Invoke-WebRequest {} -Verifiable
                Mock Get-LatestOpenVPNVersion { return "2.5.0" }
                Install-LatestOpenVPN -downloadPath $downloadPath -openVpnMsi $openVpnMsi
                Assert-MockCalled Invoke-WebRequest -Times 0 -Scope It
            }

            It "Should throw an error if given an invalid path" {
                { Install-LatestOpenVPN -downloadPath $downloadPath -openVpnMsi "invalid_path" } | Should -Throw
            }
        }
    }
}
