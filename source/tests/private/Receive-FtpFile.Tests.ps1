Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires an installed FTP/SFTP server with some folders and files for performing pester tests

Describe "Receive-FtpFile" -Tag 'Integration' {
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

        It "Downloads a file, checks its contents, and deletes the file" {
            # Download the file
            $localFile = Join-Path $env:TEMP 'license.md'
            Receive-FtpFile -server $server -user $user -password $secure -remoteFile 'License.md' -localFolder $env:TEMP

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
}
