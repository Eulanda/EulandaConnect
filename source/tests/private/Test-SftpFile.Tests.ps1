Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Test-SftpFile' -Tag 'integration', 'sftp' {
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

        It "Verifies if the SFTP file 'License.md' exists in the sftp root returns true" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFile 'License.md'
            $result | Should -Be $true
        }

        It "Verifies if the SFTP directory '/inbox' exists a file like 'NotHere.md' and returns false" {
            $result = Test-SftpFile -server $server -user $user -password $secure -remoteFolder '/inbox' -remoteFile 'NotHere.md'
            $result | Should -Be $false
        }
    }
}
