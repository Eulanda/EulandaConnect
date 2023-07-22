Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-SftpFolder' -Tag 'integration', 'sftp' {
    InModuleScope EulandaConnect {

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

        It "Verifies if the remote directory '/inbox' exists" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder '/inbox'
            $result | Should -Be $true
        }

        It "Verifies if the remote directory '/inboxSomethingElse' not exists" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder '/inboxSomethingElse'
            $result | Should -Be $false
        }
    }
}
