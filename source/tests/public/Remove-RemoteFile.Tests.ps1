Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-RemoteFile' -Tag 'integration', 'ftp', 'sftp' {

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
    It "Should upload a file, remove it, and then the file should not exist via sftp" {
        $remoteFolder = '/inbox'
        $localFile = 'Readme.md'

        # Upload the file
        Send-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder -localFolder $pesterFolder -localFile $localFile

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder

        # if no file is there
        $result | Should -Not -BeNullOrEmpty

        # The file should exist now
        if ($result) {
            $result.Contains($localFile) | Should -Be $true
        }

        # Remove the file
        Remove-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder -remoteFile $localFile

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder

        # The file should no longer exist
        if ($result) {
            $result.Contains($localFile) | Should -Be $false
        }
    }

    # **********
    # FTP calls
    # **********
    It "Should upload a file, remove it, and then the file should not exist via ftp" {
        $remoteFolder = '/inbox'
        $localFile = 'Readme.md'

        # Upload the file
        Send-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFolder $remoteFolder -localFolder $pesterFolder -localFile $localFile

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -remoteFolder $remoteFolder

        # if no file is there
        $result | Should -Not -BeNullOrEmpty

        # The file should exist now
        if ($result) {
            $result.Contains($localFile) | Should -Be $true
        }

        # Remove the file
        Remove-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFolder $remoteFolder -remoteFile $localFile

        # Check if the file exists
        $result = Get-RemoteDir -server $server -protocol ftp -user $user -password $secure -remoteFolder $remoteFolder

        # The file should no longer exist
        if ($result) {
            $result.Contains($localFile) | Should -Be $false
        }
    }

}
