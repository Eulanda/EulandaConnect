Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires a locally installed MSSQL PESTER instance with built-in security

Describe 'Get-ConnFromUdl' {
    InModuleScope 'EulandaConnect' {
        It 'should establish a connection to the MASTER database via udl' {
            $pesterFolder = Resolve-Path ".\source\tests"
            $udlFilePath = Join-Path $pesterFolder "pester.udl"
            $conn = Get-ConnFromUdl -udl  $udlFilePath
            $conn.State | Should -Be 1  # 1 is open
            $conn.close()
        }
    }
}
