Import-Module -Name .\EulandaConnect.psd1

# ATTENTION: This integration test requires MSSQL, FTP or something other

Describe 'Rename-RemoteFolder' -Tag 'integration', 'ftp', 'sftp' {

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

    # **********
    # SFTP calls
    # **********
    It "Verifies if the old remote folder exists at the beginning via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderOld
        $result | Should -Be $true
    }

    It "Verifies if the new remote folder does not exists at beginning via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderNew
        $result | Should -Not -Be $true
    }

    It "Verifies if renaming the folder works without exception via sftp" {
        {
            Rename-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderOld -newFolder $folderNew
        } | Should -Not -Throw
    }

    It "Verifies if renamed folder exists via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderNew
        $result | Should -Be $true
    }

    It "Verifies if renaming back the folder works without exception via sftp" {
        {
            Rename-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderNew -newFolder $folderOld
        } | Should -Not -Throw
    }

    It "Verifies if the remote folder exists like at beginning via sftp" {
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $folderOld
        $result | Should -Be $true
    }


    # **********
    # FTP calls
    # **********
    It "Verifies if the old remote folder exists at the beginning via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderOld
        $result | Should -Be $true
    }

    It "Verifies if the new remote folder does not exists at beginning via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderNew
        $result | Should -Not -Be $true
    }

    It "Verifies if renaming the folder works without exception via ftp" {
        {
            Rename-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderOld -newFolder $folderNew
        } | Should -Not -Throw
    }

    It "Verifies if renamed folder exists via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderNew
        $result | Should -Be $true
    }

    It "Verifies if renaming back the folder works without exception via ftp" {
        {
            Rename-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderNew -newFolder $folderOld
        } | Should -Not -Throw
    }

    It "Verifies if the remote folder exists like at beginning via ftp" {
        $result = Test-RemoteFolder -server $server -protocol ftp -user $user -password $secure -remoteFolder $folderOld
        $result | Should -Be $true
    }
}
