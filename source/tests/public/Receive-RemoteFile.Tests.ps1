Import-Module -Name .\EulandaConnect.psd1

Describe 'Receive-RemoteFile' -Tag 'integration', 'ftp', 'sftp' {

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
    It "Downloads a file, checks its contents, and deletes the file via sftp" {
        # Download the file
        $localFile = Join-Path $env:TEMP 'license.md'
        Receive-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFile 'License.md' -localFolder $env:TEMP

        # Check that the file exists
        $localFile | Should -Exist

        # Check the file contents
        $content = Get-Content -Path $localFile -Raw
        $content | Should -Match 'CONNECTION WITH THE SOFTWARE'

        # Clean up the downloaded file
        Remove-Item -Path $localFile -Force
        $localFile | Should -Not -Exist
    }

    # **********
    # FTP calls
    # **********
    It "Downloads a file, checks its contents, and deletes the file via ftp" {
        # Download the file
        $localFile = Join-Path $env:TEMP 'license.md'
        Receive-RemoteFile -server $server -protocol ftp -user $user -password $secure -remoteFile 'License.md' -localFolder $env:TEMP

        # Check that the file exists
        $localFile | Should -Exist

        # Check the file contents
        $content = Get-Content -Path $localFile -Raw
        $content | Should -Match 'CONNECTION WITH THE SOFTWARE'

        # Clean up the downloaded file
        Remove-Item -Path $localFile -Force
        $localFile | Should -Not -Exist
    }
}
