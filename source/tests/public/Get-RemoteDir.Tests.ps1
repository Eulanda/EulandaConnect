Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-RemoteDir' -Tag 'integration', 'ftp', 'sftp' {

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

    # **********
    # SFTP calls
    # **********
    It "returns the expected root directory list from remote server via sftp" {
        # Act
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -remoteFolder '/' -dirType directory

        # Assert
        $result | Should -Be $expectedOutput
    }

    It "returns directory (default root) list from remote server via sftp" {
        # Act
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -dirType directory

        # Assert
        $result | Should -Be $expectedOutput
    }

    # **********
    # FTP calls
    # **********
    It "returns the expected root directory list from remote server via ftp" {
        # Act
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -remoteFolder '/' -dirType directory

        # Assert
        $result | Should -Be $expectedOutput
    }

    It "returns directory (default root) list from remote server via ftp" {
        # Act
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -dirType directory

        # Assert
        $result | Should -Be $expectedOutput
    }
}
