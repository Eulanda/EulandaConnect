Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Rename-FtpFolder' -Tag 'integration', 'ftp' {
    InModuleScope 'EulandaConnect' {

        BeforeAll {
            $pesterFolder = Resolve-Path -path ".\source\tests"
            $iniPath = Join-Path -path $pesterFolder "pester.ini"
            $ini = Read-IniFile -path $iniPath
            $path = $ini['SFTP']['SecurePasswordPath']
            $path = $path -replace '\$home', $HOME
            $secure = Import-Clixml -path $path
            $server = $ini['SFTP']['Server']
            $user = $ini['SFTP']['User']

            $folderOld = '/inbox'
            $folderNew = '/inbox-new'
        }

        It "Verifies if the old FTP folder exists at the beginning" {
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderOld
            $result | Should -Be $true
        }


        It "Verifies if the new FTP folder does not exists at beginning" {
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderNew
            $result | Should -Not -Be $true
        }

        It "Verifies if renaming the folder works without exception" {
            {
                Rename-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderOld -newFolder $folderNew
            } | Should -Not -Throw
        }


        It "Verifies if renamed folder exists" {
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderNew
            $result | Should -Be $true
        }


        It "Verifies if renaming back the folder works without exception" {
            {
                Rename-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderNew -newFolder $folderOld
            } | Should -Not -Throw
        }

        It "Verifies if the FTP folder exists like at beginning" {
            $result = Test-FtpFolder -server $server -user $user -password $secure -remoteFolder $folderOld
            $result | Should -Be $true
        }
    }
}
