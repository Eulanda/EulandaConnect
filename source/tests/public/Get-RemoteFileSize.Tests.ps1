Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Get-RemoteFileSize' -Tag 'integration', 'sftp' {

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

        # Define the acceptable range
        $lowerBound = 512
        $upperBound = 2048
    }

    # **********
    # SFTP calls
    # **********
    It "Gets the size of the file 'License.md' and check acceptable range via sftp" {
        # Act
        $result = Get-RemoteFileSize -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md'

        # Check if the file size is within the expected range
        $result | Should -BeGreaterOrEqual $lowerBound
        $result | Should -BeLessOrEqual $upperBound
    }

    # **********
    # FTP calls
    # **********
    It "Gets the size of the file 'License.md' and check acceptable range via ftp" {
        # Act
        $result = Get-RemoteFileSize -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md'

        # Check if the file size is within the expected range
        $result | Should -BeGreaterOrEqual $lowerBound
        $result | Should -BeLessOrEqual $upperBound
    }
}
