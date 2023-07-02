Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Remove-SftpFile' -Tag 'integration', 'sftp' {
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
        }

        It "Should upload a file, remove it, and then the file should not exist" {
            $remoteFolder = '/inbox'
            $localFile = 'Readme.md'

            # Upload the file
            Send-SftpFile -server $server -user $user -password $secure -remoteFolder $remoteFolder -localFolder $pesterFolder -localFile $localFile

            # Check if the file exists
            $result = Get-SftpDir -server $server -user $user -password $secure -remoteFolder $remoteFolder

            # if no file is there
            $result | Should -Not -BeNullOrEmpty

            # The file should exist now
            if ($result) {
                $result.Contains($localFile) | Should -Be $true
            }

            # Remove the file
            Remove-SftpFile -server $server -user $user -password $secure -remoteFolder $remoteFolder -remoteFile $localFile

            # Check if the file exists
            $result = Get-SftpDir -server $server -user $user -password $secure -remoteFolder $remoteFolder

            # The file should no longer exist
            if ($result) {
                $result.Contains($localFile) | Should -Be $false
            }
        }
    }
}
