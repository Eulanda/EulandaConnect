Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-RemoteFileDate' -Tag 'integration', 'ftp', 'sftp' {

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

        # Calculate the acceptable range
        $now = Get-Date
        $earliest = [DateTime]::new(2023, 1, 1)
        $latest = $now.AddMinutes(-10)
    }

    # **********
    # SFTP calls
    # **********
    It "Gets the change date of the file 'License.md' and check acceptable range via sftp" {
        # Act
        $result = Get-RemoteFileDate -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md'

        # Check if the date of the file is older than 10 minutes from now.
        $result | Should -BeLessOrEqual $latest

        # Check if the date of the file is newer or equal to 01.01.2023
        $result | Should -BeGreaterOrEqual $earliest
    }

    # **********
    # FTP calls
    # **********
    It "Gets the change date of the file 'License.md' and check acceptable range via ftp" {
        # Act
        $result = Get-RemoteFileDate -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md'

        # Check if the date of the file is older than 10 minutes from now.
        $result | Should -BeLessOrEqual $latest

        # Check if the date of the file is newer or equal to 01.01.2023
        $result | Should -BeGreaterOrEqual $earliest
    }
}
