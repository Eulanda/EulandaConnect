Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Send-SftpFile' -Tag 'integration', 'sftp' {
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

        It 'sends file and verifies its existence' {
            $remoteFolder = '/inbox'
            $localFile = 'Readme.md'

            Send-SftpFile -server $server -user $user -password $secure -remoteFolder $remoteFolder -localFolder $pesterFolder -localFile $localFile

            $result = Get-SftpDir -server $server -user $user -password $secure -remoteFolder $remoteFolder

            # if no file is there it is an error
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
