Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Backup-MssqlDatabase' -Tag 'integration', 'sql', 'ftp', 'sftp' {

    BeforeAll {
        $tempFolder = Join-Path -Path $env:TEMP -ChildPath (Get-Random)
        New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null

        # Arrange
        $pesterFolder = Resolve-Path -path ".\source\tests"
        $iniPath = Join-Path -path $pesterFolder "pester.ini"
        $ini = Read-IniFile -path $iniPath
        $path = $ini['SFTP']['SecurePasswordPath']
        $path = $path -replace '\$home', $HOME
        $secure = Import-Clixml -path $path
        $server = $ini['SFTP']['Server']
        $user = $ini['SFTP']['User']

        $remoteFolder = '/inbox/PESTER'


        # Act
        $backupPath = Backup-MssqlDatabase `
            -udl "$pesterFolder\Eulanda_1 Pester.udl" `
            -storageFolder $tempFolder `
            -server $server `
            -protocol sftp `
            -user $user `
            -password $secure `
            -remoteFolder '/inbox'

        $fileStorage = Get-ChildItem -Path $tempFolder -File -Filter "*.zip" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

        if ($fileStorage) {
            $storageFileName = $fileStorage.Name
            $remoteFile = $fileStorage.Name
        } else {
            $storageFileName = ""
            $remoteFile = ""
        }
    }


    It 'Backup file should exist in standard mssql backup folder' {
        Write-Host "Backup file: $backupPath"
        $backupPath | Should -Exist
        $backupPath | Should -Match '.zip'
    }

    It 'Backup in local storage with datetime in file name should exist' {
        $storageFileName | Should -Not -BeNullOrEmpty
    }

    It 'Backup file with datetime in file name should exist on remote server' {
        Write-Host "RemoteFile $remoteFile"
        $ftpFileFound = Test-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder -remoteFile $remoteFile
        $ftpFileFound | Should -Be $true
    }

    AfterAll {
        # Cleanup local file from storageFolder
        Remove-Item -Path $tempFolder -Recurse -Force

        # Cleanup remote file
        $remoteFile = $fileStorage.Name
        Remove-RemoteFile -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder -remoteFile $remoteFile
        Remove-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder
        $result = Test-RemoteFolder -server $server -protocol sftp -user $user -password $secure -remoteFolder $remoteFolder
        $result | Should -Be $false
    }
}
