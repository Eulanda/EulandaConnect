function Backup-MssqlDatabase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$server
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet("ftp", "ftps", "sftp")]
        [string]$protocol = 'sftp'
        ,
        [Parameter(Mandatory = $false)]
        [int]$port = $(if ($protocol -eq "ftp") {21} elseif ($protocol -eq "ftps") {21} elseif ($protocol -eq "sftp") {22})
        ,
        [Parameter(Mandatory = $false)]
        [switch]$activeMode
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeAge = 60*60*3
        ,
        [Parameter(Mandatory = $false)]
        [int]$resumeRetries = 7
        ,
        [Parameter(Mandatory = $false)]
        [string]$certificate
        ,
        [Parameter(Mandatory = $false)]
        [string]$user
        ,
        [Parameter(Mandatory = $false)]
        $password
        ,
        [Parameter(Mandatory = $false)]
        [string]$remoteFolder
        ,
        [Parameter(Mandatory = $false)]
        [string]$storageFolder
        ,
        [Parameter(Mandatory = $false)]
        [switch]$removeBak
        ,
        [Parameter(Mandatory = $false)]
        [int]$history = 3
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters

        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Get connection and open it
        $myConn = Get-Conn -conn $conn -ConnStr $connStr -udl $udl

        # Extract parameters from connection
        $connItems = Get-ConnItems -conn $myConn
        [string]$datasource = $connItems['Data Source']
        [string]$database = $connItems['Initial Catalog']
        [string[]]$splitDataSource = $datasource -split '\\'
        if ($splitDataSource.Count -gt 1) {
            [string]$instance = $splitDataSource[1]
        } else {
            [string]$instance = "MSSQLSERVER"
        }

        # Get standard backup path
        [hashtable]$instances = @{}
        Get-MssqlInstances | ForEach-Object { $instances[$_.Instance] = $_ }
        [string]$backupPath = $instances[$instance].BackupPath

        # Backup database from connection
        $backupFile = "$backupPath\$database.bak"
        $sql = "BACKUP DATABASE [$database] TO  DISK = N'$backupFile' WITH FORMAT, INIT,  NAME = N'Full Database Backup', SKIP, NOREWIND, NOUNLOAD, NO_COMPRESSION,  STATS = 10"
        Write-Verbose ((Get-ResStr 'VERBOSE_BACKUP_DATABASE_TO_FILE') -f $database, $backupFile)
        $myConn.Execute($sql) | Out-Null

        # Zip the database backup file
        $zipFile = "$backupPath\$database.zip"
        $result = $zipFile
        $sourcePath = $backupFile
        $sourceFiles = Get-ChildItem -Path $sourcePath -Recurse
        Write-Verbose "Zip database as '$zipFile'"
        $sourceFiles | ForEach-Object {
            $currentFile = $_
            Compress-Archive -Path $currentFile.FullName -DestinationPath $zipFile -CompressionLevel Optimal -Update
        }

        # Create time stamp to enhance the filename to be stored
        [string]$timeStamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss-ffff"


        # Filesystem is used for storeing zip file
        if ($storageFolder) {
            Write-Verbose ((Get-ResStr 'VERBOSE_COPY_ZIP_TO_FILE') -f  "$storageFolder\$database-$timeStamp.zip")
            Copy-Item -Path $zipFile -Destination "$storageFolder\$database-$timeStamp.zip" -Force

            $files = Get-ChildItem -Path $storageFolder -File | Select-Object -ExpandProperty Name
            $files = Select-OutdatedFilenames -filenames $files -basename $database -extension '.zip' -history $history
            foreach ($file in $files) {
                Remove-Item -Path "$storageFolder\$file" -Force
                Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_FILE_FROM_STORAGE') -f "$storageFolder\$file")
            }
        }

        # Remote server (ftp/sftp) is used for storeing zip file
        if ($server) {
            if ($password.GetType().Name -eq 'String') {
                [securestring]$password = ConvertTo-SecureString -String $password -AsPlainText -Force
            }

            $remoteFinalFolder = "$($remoteFolder.TrimEnd('/'))/$instance"
            $remoteFinalFolder = "$($remoteFinalFolder.TrimEnd('/'))"

            $remoteParams = @{
                server = $server
                protocol = $protocol
                port = $port
                activeMode = $activeMode
                certificate = $certificate
                user = $user
                password = $password
            }

            $folderParams = @{
                localFolder = $backupPath
                localFile = "$database.zip"
                remoteFolder = $remoteFinalFolder
                remoteFile = "$database-$timeStamp.zip"
            }

            Send-RemoteFile @remoteParams @folderParams -resumeAge $resumeAge -resumeRetries $resumeRetries
            $files = Get-RemoteDir @remoteParams -mask '*.zip' -remoteFolder $remoteFinalFolder
            $files = Select-OutdatedFilenames -filenames $files -basename $database -extension '.zip' -history $history
            foreach ($file in $files) {
                Remove-RemoteFile @remoteParams -remoteFolder $remoteFinalFolder -remoteFile $file
                Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_FILE_FROM_REMOTE') -f "$remoteFinalFolder/$file")
            }
        }

        # Clean-Up mssql backup folder
        if ($removeBak) {
            Remove-Item $backupFile -force
            Write-Verbose ((Get-ResStr 'VERBOSE_DELETED_BACKUP_FROM_SQL') -f "$backupFile")
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Backup-MssqlDatabase -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -storageFolder 'C:\store' -server 'mysftp.eulanda.eu' -user 'johndoe' -password 'superPass'
}
