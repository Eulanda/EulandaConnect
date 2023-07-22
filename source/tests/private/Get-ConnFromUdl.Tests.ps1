Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ConnFromUdl' -Tag 'integration', 'sql' {
    InModuleScope EulandaConnect {

        It 'should establish a connection to the MASTER database via udl' {
            $pesterFolder = Resolve-Path ".\source\tests"
            $udlFilePath = Join-Path $pesterFolder "pester.udl"
            $conn = Get-ConnFromUdl -udl  $udlFilePath
            $conn.State | Should -Be 1  # 1 is open
            $conn.close()
        }
    }
}
