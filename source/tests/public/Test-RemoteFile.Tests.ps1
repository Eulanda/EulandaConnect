Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-RemoteFile' -Tag 'integration', 'ftp', 'sftp' {

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
    It "Verifies if the remote file 'License.md' exists in root via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }

    It "Verifies if the remote directory '/inbox' exists a file like 'NotHere.md' via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFolder '/inbox' -remoteFile 'NotHere.md'
        $result | Should -Be $false
    }


    # **********
    # FTP calls
    # **********
    It "Verifies if the remote file 'License.md' exists in root via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }

    It "Verifies if the remote directory '/inbox' exists a file like 'NotHere.md' via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFolder '/inbox' -remoteFile 'NotHere.md'
        $result | Should -Be $false
    }

}
