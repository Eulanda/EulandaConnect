Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-SftpFolder' -Tag 'integration', 'sftp' {
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
        }

        It "Should remove an remote folder, but before that must be created" {

            # Generate a random string of 10 characters for the folder name
            $folderName = -join ((65..90) | Get-Random -Count 10 | ForEach-Object {[char]$_})

            # Create a random folder so that we can test the remove folder function.
            New-SftpFolder -server $server -user $user -password $secure -remoteFolder "/$folderName"

            # Check if the file exists
            $result = Get-SftpDir -server $server -user $user -password $secure -dirType directory
            $result | Should -Contain $folderName

            # Remove the new folder
            Remove-SftpFolder -server $server -user $user -password $secure -remoteFolder "/$folderName"

            # Re-Read the directory for folder
            $result = Get-SftpDir -server $server -user $user -password $secure -dirType directory

            # The file should no longer exist
            if ($result) {
                $result.Contains($folderName) | Should -Be $false
            }
        }
    }
}
