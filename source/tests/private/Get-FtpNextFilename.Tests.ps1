Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-FtpNextFilename' -Tag 'integration', 'ftp' {
    InModuleScope EulandaConnect {

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

        It "Gets the next file name from the remote folder and checks if it is 'License.md'" {
            $result = Get-FtpNextFilename -server $server -user $user -password $secure -mask '*.md'
            $result | Should -Be 'License.md'
        }

        It "Checks if the /outbox folder is empty" {
            $result = Get-FtpNextFilename -server $server -user $user -password $secure -remoteFolder '/outbox'
            $result | Should -BeNullOrEmpty
        }
    }
}
