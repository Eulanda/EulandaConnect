Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-FtpFile' -Tag 'integration', 'ftp' {
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

        It "Verifies if the remote file 'License.md' exists in root" {
            $result = Test-FtpFile -server $server -user $user -password $secure -remoteFile 'License.md'
            $result | Should -Be $true
        }

        It "Verifies if the remote directory '/inbox' exists a file like 'NotHere.md'" {
            $result = Test-FtpFile -server $server -user $user -password $secure -remoteFolder '/inbox' -remoteFile 'NotHere.md'
            $result | Should -Be $false
        }
    }
}
