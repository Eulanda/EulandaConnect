Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Split-LogFile' {

    BeforeAll {
        # Prepare Test Log file
        $tempDirectory = [System.IO.Path]::GetTempPath()
        $testInputPath = Join-Path $tempDirectory 'FileZillaLog\Logs'
        $testOutputPath = Join-Path $tempDirectory 'FileZillaLog\SplitLogs'
        $testLogFile = Join-Path $testInputPath 'filezilla-server.2023-07-22.log'

        # Ensure test directories exist
        New-Item -ItemType Directory -Force -Path $testInputPath
        New-Item -ItemType Directory -Force -Path $testOutputPath

        # Generate a sample log file
        $logContent = @(
            '2023-07-16T02:18:53.318Z << [FTP Session 2856 64.62.197.239] 220 welcome to ftp connect service',
            '2023-07-16T02:18:53.490Z >> [FTP Session 2856 64.62.197.239] AUTH TLS',
            '2023-07-16T02:18:53.490Z << [FTP Session 2856 64.62.197.239] 234 Using authentication type TLS.',
            '2023-07-16T02:18:53.974Z !! [FTP Session 2856 64.62.197.239] GnuTLS error -110 in gnutls_record_recv: The TLS connection was non-properly terminated.',
            '2023-07-16T02:18:53.974Z == [FTP Session 2856 64.62.197.239] Client did not properly shut down TLS connection',
            '2023-07-16T02:18:53.974Z !! [FTP Session 2856 64.62.197.239] Control channel closed with error from source 0. Reason: ECONNABORTED - Connection aborted.',
            '2023-07-16T02:30:06.782Z << [FTP Session 2857 5.21.80.217] 220-FileZilla Pro Enterprise Server 1.7.2',
            '2023-07-16T02:30:06.782Z << [FTP Session 2857 5.21.80.217] 220-Please visit https://filezilla-project.org/',
            '2023-07-16T02:30:06.782Z << [FTP Session 2857 5.21.80.217] 220 welcome to ftp connect service',
            '2023-07-16T02:30:06.782Z >> [FTP Session 2857 5.21.80.217] USER komu',
            '2023-07-16T02:30:06.782Z << [FTP Session 2857 5.21.80.217] 331 Please, specify the password.',
            '2023-07-16T02:30:06.782Z >> [FTP Session 2857 5.21.80.217] PASS ****',
            '2023-07-16T02:30:06.860Z << [FTP Session 2857 5.21.80.217 komu] 230 Login successful.',
            '2023-07-16T02:30:06.860Z >> [FTP Session 2857 5.21.80.217 komu] OPTS utf8 on',
            '2023-07-16T02:30:06.860Z << [FTP Session 2857 5.21.80.217 komu] 202 UTF8 mode is always enabled. No need to send this command',
            '2023-07-16T02:30:06.860Z >> [FTP Session 2857 5.21.80.217 komu] PWD',
            '2023-07-16T02:30:06.860Z << [FTP Session 2857 5.21.80.217 komu] 257 "/" is current directory.',
            '2023-07-16T02:30:06.860Z >> [FTP Session 2857 5.21.80.217 komu] TYPE I',
            '2023-07-16T02:30:06.860Z << [FTP Session 2857 5.21.80.217 komu] 200 Type set to I',
            '2023-07-16T02:30:06.860Z >> [FTP Session 2857 5.21.80.217 komu] PASV',
            '2023-07-16T02:30:06.860Z << [FTP Session 2857 5.21.80.217 komu] 227 Entering Passive Mode (5,21,80,221,194,144)',
            '2023-07-16T02:30:06.860Z >> [FTP Session 2857 5.21.80.217 komu] RETR partnerliste/partnerliste.htm',
            '2023-07-16T02:30:06.938Z << [FTP Session 2857 5.21.80.217 komu] 150 Starting data transfer.',
            '2023-07-16T02:30:06.938Z << [FTP Session 2857 5.21.80.217 komu] 226 Operation successful',
            '2023-07-16T02:30:06.938Z >> [FTP Session 2857 5.21.80.217 komu] QUIT',
            '2023-07-16T02:30:06.938Z << [FTP Session 2857 5.21.80.217 komu] 221 Goodbye.',
            '2023-07-16T02:30:06.938Z == [FTP Server] Session 2857 ended gracefully.',
            '2023-07-16T02:33:06.323Z >> [SSH SFTP Session 2858 141.98.11.113] SSH User Authentication [method=none, user=mysql, service=ssh-connection]',
            '2023-07-16T02:33:06.323Z == [SSH SFTP Session 2858 141.98.11.113] Client tried ''none'' authentication method which is not available. There are no further methods available: User is disabled.',
            '2023-07-16T02:33:06.354Z >> [SSH SFTP Session 2858 141.98.11.113] SSH User Authentication [method=password, user=mysql, service=ssh-connection]',
            '2023-07-16T02:33:06.354Z !! [SSH SFTP Session 2858 141.98.11.113] User authentication attempt with method ''password'' failed [user=mysql] [next methods=no auth methods available] [error=Auth method is not supported]',
            '2023-07-16T02:33:06.385Z == [SSH SFTP Session 2858 141.98.11.113] Closing connection [code=0]',
            '2023-07-16T02:33:06.385Z == [SSH SFTP Server] Session 2858 ended gracefully.',
            '2023-07-16T02:33:51.477Z == [SSH SFTP Session 2859 170.64.166.150] Closing connection [code=0]',
            '2023-07-16T02:33:51.477Z == [SSH SFTP Server] Session 2859 ended gracefully.',
            '2023-07-16T02:43:47.535Z == [SSH SFTP Session 2860 104.152.52.137] Closing connection [code=0]',
            '2023-07-16T02:43:47.535Z == [SSH SFTP Server] Session 2860 ended gracefully.',
            '2023-07-16T02:43:47.629Z << [FTP Session 2861 104.152.52.137] 220-FileZilla Pro Enterprise Server 1.7.2',
            '2023-07-16T02:43:47.629Z << [FTP Session 2861 104.152.52.137] 220-Please visit https://filezilla-project.org/',
            '2023-07-16T02:43:47.629Z << [FTP Session 2861 104.152.52.137] 220 welcome to ftp connect service',
            '2023-07-16T02:43:47.723Z >> [FTP Session 2861 104.152.52.137] AUTH TLS',
            '2023-07-16T02:43:47.739Z << [FTP Session 2861 104.152.52.137] 234 Using authentication type TLS.',
            '2023-07-16T02:43:47.832Z !! [FTP Session 2861 104.152.52.137] GnuTLS error -8: A packet with illegal or unsupported version was received.',
            '2023-07-16T02:43:47.832Z !! [FTP Session 2861 104.152.52.137] Control channel closed with error from source 0. Reason: ECONNABORTED - Connection aborted.',
            '2023-07-16T02:50:38.804Z >> [SSH SFTP Session 2862 176.113.115.211] SSH User Authentication [method=none, user=12345, service=ssh-connection]',
            '2023-07-16T02:50:38.804Z == [SSH SFTP Session 2862 176.113.115.211] Client tried ''none'' authentication method which is not available. There are no further methods available: User is disabled.',
            '2023-07-16T02:50:38.835Z >> [SSH SFTP Session 2862 176.113.115.211] SSH User Authentication [method=password, user=12345, service=ssh-connection]',
            '2023-07-16T02:50:38.835Z !! [SSH SFTP Session 2862 176.113.115.211] User authentication attempt with method ''password'' failed [user=12345] [next methods=no auth methods available] [error=Auth method is not supported]',
            '2023-07-16T02:50:38.867Z == [SSH SFTP Session 2862 176.113.115.211] Closing connection [code=0]',
            '2023-07-16T02:50:38.867Z == [SSH SFTP Server] Session 2862 ended gracefully.'
        )
        $logContent | Out-File -FilePath $testLogFile -Force
    }

    It "Can split log files" {
        # Arrange
        $inputPath = Join-Path $testInputPath 'filezilla-server.*.log'
        $outputFolder = $testOutputPath

        # Act
        Split-LogFile -inputPath $inputPath -outputFolder $outputFolder -maxFileSize 512 -ErrorAction Stop

        # Assert
        $splitLogFiles = Get-ChildItem -Path $outputFolder -File
        $splitLogFiles.Count | Should -BeGreaterThan 0
    }

    AfterAll {
        Remove-Item -Path $testInputPath -Force -Recurse
        Remove-Item -Path $testOutputPath -Force -Recurse
    }
}
