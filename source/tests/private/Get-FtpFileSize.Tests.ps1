Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe "Get-FtpFileSize" -Tag 'integration','ftp' {
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
            $result = Get-FtpFileSize -server $server -user $user -password $secure -remoteFile 'License.md'

            # Define the acceptable range
            $lowerBound = 512
            $upperBound = 2048
        }

        It "Gets the size of the file 'License.md' and checks if it's within an acceptable range" {
             # Check if the file size is within the expected range
             $result | Should -BeGreaterOrEqual $lowerBound
             $result | Should -BeLessOrEqual $upperBound
        }
    }
}
