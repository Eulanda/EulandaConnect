Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires an installed FTP/SFTP server with some folders and files for performing pester tests

Describe "New-FtpFolder" -Tag 'Integration' {
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

            # Generate a random string of 10 characters for the folder name
            $folderName = -join ((65..90) | Get-Random -Count 10 | ForEach-Object {[char]$_})

            # Act
            New-FtpFolder -server $server -user $user -password $secure -remoteFolder "/$folderName"
        }

        It "Creates a new folder and checks if it is listed in the remote directory" {
            # Assert

            # Check if the new folder is in the remote directory
            $result = Get-FtpDir -server $server -user $user -password $secure -dirType directory
            $result | Should -Contain $folderName
        }
    }
}
