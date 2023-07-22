Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-RemoteFolder' -Tag 'integration', 'ftp', 'sftp' {

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

    # **********
    # SFTP calls
    # **********
    It "Verifies if the remote directory '/inbox' exists via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder '/inbox'
        $result | Should -Be $true
    }

    It "Verifies if the remote directory '/inboxSomethingElse' not exists via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder '/inboxSomethingElse'
        $result | Should -Be $false
    }


    # **********
    # FTP calls
    # **********
    It "Verifies if the remote directory '/inbox' exists via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder '/inbox'
        $result | Should -Be $true
    }

    It "Verifies if the remote directory '/inboxSomethingElse' not exists via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder '/inboxSomethingElse'
        $result | Should -Be $false
    }
}
