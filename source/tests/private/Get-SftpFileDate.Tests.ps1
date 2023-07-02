Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Get-SftpFileDate' -Tag 'integration', 'sftp' {
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

            # Act
            $result = Get-SftpFileDate -server $server -user $user -password $secure -remoteFile 'License.md'

            # Calculate the acceptable range
            $now = Get-Date
            $earliest = [DateTime]::new(2023, 1, 1)
            $latest = $now.AddMinutes(-10)
        }

        It "Gets the change date of the file 'License.md' and checks if it's within an acceptable range" {

            # Check if the date of the file is older than 10 minutes from now.
            $result | Should -BeLessOrEqual $latest

            # Check if the date of the file is newer or equal to 01.01.2023
            $result | Should -BeGreaterOrEqual $earliest
        }
    }
}
