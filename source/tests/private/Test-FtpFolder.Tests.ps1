Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-FtpFolder' -Tag 'integration', 'ftp' {
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
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder '/inbox'
            $result | Should -Be $true
        }

        It "Verifies if the remote directory '/inboxSomethingElse' not exists" {
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder '/inboxSomethingElse'
            $result | Should -Be $false
        }
    }
}
