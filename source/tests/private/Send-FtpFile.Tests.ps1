Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires an installed FTP/SFTP server with some folders and files for performing pester tests

Describe "Send-FtpFile" -Tag 'Integration' {
    InModuleScope 'EulandaConnect' {
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

        It 'sends file and verifies its existence' {
            Send-FtpFile -server $server -user $user -password $secure -remoteFolder '/inbox' -localFolder $pesterFolder -localFile 'Readme.md'

            $result = Get-FtpDir -server $server -user $user -password $secure -remoteFolder '/inbox'
            $result | Should -Contain 'Readme.md'
        }
    }
}
