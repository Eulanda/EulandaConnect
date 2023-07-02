Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Get-FtpFileAge' -Tag 'integration', 'ftp' {
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

            # Calculate the acceptable range
            $now = Get-Date
            $earliest = [DateTime]::new(2023, 1, 1)
            $latest = $now.AddMinutes(-10)

            $earliestSeconds = ($now - $earliest).TotalSeconds
            $latestSeconds = ($now - $latest).TotalSeconds
        }

        It "Gets the age of the file 'License.md' in seconds and check acceptable range" {
            # Act
            $result = Get-FtpFileAge -server $server -user $user -password $secure -remoteFile 'License.md'

            # Check if the age of the file is less than the difference in seconds since 01.01.2023
            $result | Should -BeLessOrEqual $earliestSeconds

            # Check if the age of the file is greater than 10 minutes
            $result | Should -BeGreaterOrEqual $latestSeconds
        }
    }
}
