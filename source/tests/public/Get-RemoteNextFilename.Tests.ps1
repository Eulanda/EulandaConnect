Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-RemoteNextFilename' -Tag 'integration', 'ftp', 'sftp' {

    BeforeAll {
        # Arrange
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
    It "Gets the next file name from the remote folder and checks if it is 'License.md' via sftp" {
        $result = Get-RemoteNextFilename -server $server -protocol sftp -user $user -password $secure -mask '*.md'
        $result | Should -Be 'License.md'
    }

    It "Checks if the /outbox folder is empty via sftp" {
        $result = Get-RemoteNextFilename -server $server -protocol sftp -user $user -password $secure -remoteFolder '/outbox'
        $result | Should -BeNullOrEmpty
    }

    # **********
    # FTP calls
    # **********
    It "Gets the next file name from the remote folder and checks if it is 'License.md' via ftp" {
        $result = Get-RemoteNextFilename -server $server -protocol ftp -user $user -password $secure -mask '*.md'
        $result | Should -Be 'License.md'
    }

    It "Checks if the /outbox folder is empty via ftp" {
        $result = Get-RemoteNextFilename -server $server -protocol ftp -user $user -password $secure -remoteFolder '/outbox'
        $result | Should -BeNullOrEmpty
    }
}
