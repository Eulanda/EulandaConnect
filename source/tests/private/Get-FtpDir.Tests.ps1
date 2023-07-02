Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Get-FtpDir' -Tag 'integration', 'ftp' {
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            $pesterFolder = Resolve-Path -Path ".\source\tests"
            $iniPath = Join-Path -Path $pesterFolder "pester.ini"
            $ini = Read-IniFile -Path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -Path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']

            $expectedOutput = @('inbox', 'outbox') # Update this to reflect the actual output
        }

        It "returns the expected root directory list from FTP server" {
            # Act
            $result = Get-FtpDir -server $server -user $user -password $secure -remoteFolder '/' -dirType directory

            # Assert
            $result | Should -Be $expectedOutput
        }

        It "returns directory (default root) list from FTP server" {
            # Act
            $result = Get-FtpDir -server $server -user $user -password $secure -dirType directory

            # Assert
            $result | Should -Be $expectedOutput
        }
    }
}
