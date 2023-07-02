Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'New-RemoteFolder' -Tag 'integration', 'ftp', 'sftp' {

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

    # **********
    # SFTP calls
    # **********
    It "Creates a new folder and checks if it is listed in the remote directory via sftp" {

        # Generate a random string of 10 characters for the folder name
        $folderName = -join ((65..90) | Get-Random -Count 10 | ForEach-Object {[char]$_})

        # Create a random folder
        New-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder "/$folderName"

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -dirType directory
        $result | Should -Contain $folderName

        # Remove the new folder
        Remove-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder "/$folderName"

        # Re-Read the directory for folder
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -dirType directory

        # The file should no longer exist
        if ($result) {
            $result.Contains($folderName) | Should -Be $false
        }
    }


    # **********
    # FTP calls
    # **********
    It "Creates a new folder and checks if it is listed in the remote directory via ftp" {

        # Generate a random string of 10 characters for the folder name
        $folderName = -join ((65..90) | Get-Random -Count 10 | ForEach-Object {[char]$_})

        # Create a random folder
        New-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder "/$folderName"

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -dirType directory
        $result | Should -Contain $folderName

        # Remove the new folder
        Remove-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder "/$folderName"

        # Re-Read the directory for folder
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -dirType directory

        # The file should no longer exist
        if ($result) {
            $result.Contains($folderName) | Should -Be $false
        }
    }

}
