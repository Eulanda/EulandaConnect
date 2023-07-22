Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SftpFileSize' -Tag 'integration', 'sftp' {
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

            # Define the acceptable range
            $lowerBound = 512
            $upperBound = 2048
        }

        It "Gets the size of the file 'License.md' and check acceptable range" {

            # Act
            $result = Get-SftpFileSize -server $server -user $user -password $secure -remoteFile 'License.md'

            # Check if the file size is within the expected range
            $result | Should -BeGreaterOrEqual $lowerBound
            $result | Should -BeLessOrEqual $upperBound
        }
    }
}
