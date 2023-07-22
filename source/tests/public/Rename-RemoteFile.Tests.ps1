Import-Module -Name .\EulandaConnect.psd1

Describe 'Rename-RemoteFile' -Tag 'integration', 'ftp', 'sftp' {

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
    It "Verifies if the remote  file 'License.md' exists at the beginning via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }

    It "Verifies if the remote file 'License.txt' does not exists at beginning via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.txt'
        $result | Should -Not -Be $true
    }

    It "Verifies if renaming the file to txt works without exception via sftp" {
        {
            Rename-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md' -newFile 'License.txt'
        } | Should -Not -Throw
    }

    It "Verifies if renamed remote file 'License.txt' exists via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.txt'
        $result | Should -Be $true
    }

    It "Verifies if renaming back the file works without exception via sftp" {
        {
            Rename-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.txt' -newFile 'License.md'
        } | Should -Not -Throw
    }

    It "Verifies if the remote file 'License.md' exists like at beginning via sftp" {
        $result = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }

    # **********
    # FTP calls
    # **********
    It "Verifies if the remote  file 'License.md' exists at the beginning via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }

    It "Verifies if the remote file 'License.txt' does not exists at beginning via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.txt'
        $result | Should -Not -Be $true
    }

    It "Verifies if renaming the file to txt works without exception via ftp" {
        {
            Rename-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md' -newFile 'License.txt'
        } | Should -Not -Throw
    }

    It "Verifies if renamed remote file 'License.txt' exists via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.txt'
        $result | Should -Be $true
    }

    It "Verifies if renaming back the file works without exception via ftp" {
        {
            Rename-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.txt' -newFile 'License.md'
        } | Should -Not -Throw
    }

    It "Verifies if the remote file 'License.md' exists like at beginning via ftp" {
        $result = Test-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md'
        $result | Should -Be $true
    }
}
