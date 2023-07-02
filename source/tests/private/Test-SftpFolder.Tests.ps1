Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Test-SftpFolder' -Tag 'integration', 'sftp' {
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $iniPath = Join-Path -path $pesterFolder "pester.ini"
            $ini = Read-IniFile -path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']
        }

        It "Verifies if the SFTP directory '/inbox' exists and returns true" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder '/inbox'
            $result | Should -Be $true
        }

        It "Verifies if the SFTP directory '/inboxSomethingElse' exists and returns false" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder '/inboxSomethingElse'
            $result | Should -Be $false
        }
    }
}
