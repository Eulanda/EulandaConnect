Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Rename-SftpFile' -Tag 'integration', 'sftp' {
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

        It "Verifies if the remote  file 'License.md' exists at the beginning" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFile 'License.md'
            $result | Should -Be $true
        }

        It "Verifies if the remote file 'License.txt' does not exists at beginning" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFile 'License.txt'
            $result | Should -Not -Be $true
        }

        It "Verifies if renaming the file to txt works without exception" {
            {
                Rename-SftpFile -server $server -user $user -password $secure -remoteFile 'License.md' -newFile 'License.txt'
            } | Should -Not -Throw
        }

        It "Verifies if renamed remote file 'License.txt' exists" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFile 'License.txt'
            $result | Should -Be $true
        }

        It "Verifies if renaming back the file works without exception" {
            {
                Rename-SftpFile -server $server -user $user -password $secure -remoteFile 'License.txt' -newFile 'License.md'
            } | Should -Not -Throw
        }

        It "Verifies if the remote file 'License.md' exists like at beginning" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFile 'License.md'
            $result | Should -Be $true
        }

    }
}
