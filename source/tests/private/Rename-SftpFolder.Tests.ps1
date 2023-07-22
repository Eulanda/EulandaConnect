Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Rename-SftpFolder' -Tag 'integration', 'sftp' {
    InModuleScope EulandaConnect {

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

        It "Verifies if the old remote folder exists at the beginning" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderOld
            $result | Should -Be $true
        }


        It "Verifies if the new remote folder does not exists at beginning" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderNew
            $result | Should -Not -Be $true
        }

        It "Verifies if renaming the folder works without exception" {
            {
                Rename-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderOld -newFolder $folderNew
            } | Should -Not -Throw
        }


        It "Verifies if renamed folder exists" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderNew
            $result | Should -Be $true
        }


        It "Verifies if renaming back the folder works without exception" {
            {
                Rename-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderNew -newFolder $folderOld
            } | Should -Not -Throw
        }

        It "Verifies if the remote folder exists like at beginning" {
            $result = Test-SftpFolder -server $server -user $user -password $secure -remoteFolder $folderOld
            $result | Should -Be $true
        }
    }
}
