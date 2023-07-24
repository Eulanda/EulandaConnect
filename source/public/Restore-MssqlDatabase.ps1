function Restore-MssqlDatabase {
    [CmdletBinding()]
    param(
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
        # Get a temporary connection string
        if ($conn) {
            if ($conn.status -eq 1) {
                $tempConnStr = $conn.ConnectionString
            }
            $tempUdl = (($conn.ConnectionString) -split "=")[1].trim()
            $udlContent = Get-Content -Path $tempUdl
            $tempConnStr = $udlContent | Where-Object {
                $_ -match '^.+=.+$'
            }
        } elseif ($udl) {
            $udlContent = Get-Content -Path $udl
            $tempConnStr = $udlContent | Where-Object {
                $_ -match '^.+=.+$'
            }
        } else {
            $tempConnStr = $connStr
        }


        # Build a hashtable of all items
        $connItems = @{}
        $tempConnStr -split ';' | ForEach-Object {
            $keyValue = $_ -split '='
            if ($keyValue.Count -eq 2) {
                $key = $keyValue[0].Trim()
                $value = $keyValue[1].Trim()
                if ($key -ne '') {
                    $connItems[$key] = $value
                }
            }
        }

        [string]$database = $connItems['Initial Catalog']
        [string]$datasource = $connItems['Data Source']
        [string[]]$splitDataSource = $datasource -split '\\'
        if ($splitDataSource.Count -gt 1) {
            [string]$instance = $splitDataSource[1]
        } else {
            [string]$instance = "MSSQLSERVER"
        }


        # Patch to master database
        $connItems['Initial Catalog'] = 'master'


        # Build a new connection string and open the connection
        $masterConnStr = ($connItems.GetEnumerator() | ForEach-Object {
            "$($_.Key)=$($_.Value)"
        }) -join ';'
        $masterConn = Get-Conn -connStr $masterConnStr


        # Get standard backup path
        [hashtable]$instances = @{}
        Get-MssqlInstances | ForEach-Object { $instances[$_.Instance] = $_ }
        [string]$backupPath = $instances[$instance].BackupPath


        # Restore database from connection
        $backupFile = "$backupPath\$database.bak"


        $sql = "SELECT DB_ID('$database')"
        $rs = $masterConn.Execute($sql)

        if ($rs -and -not $rs.EOF) {
            $id = $rs.Fields.Item(0).Value
            if ([DBNull]::Value -eq $id) { $id = [int]0 } else { $id = [int]$id }
        } else {
            $id = [int]0
        }


        # This type of restore ONLY supports the same folder structure as the backup at this time.
        if ($id) {
            $sql = @(
                "USE [master];",
                "ALTER DATABASE [$database] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;",
                "RESTORE DATABASE [$database]",
                "FROM DISK = '$backupPath\$database.bak';",
                "ALTER DATABASE [$database] SET MULTI_USER;"
            )
        } else {
            $sql = @(
                "USE [master];",
                "RESTORE DATABASE [$database]",
                "FROM DISK = '$backupPath\$database.bak';"
            )
        }


        $sql = $sql -join("`r`n")

        $masterConn.Execute($sql) | Out-Null
        if ($masterConn.Errors.count -gt 0) {
            $errMessage = ""
            foreach ($e in $masterConn.Errors) {
                $errMessage = $errMessage + " " + $e.description
            }
            $errMessage = $errMessage.Trim()
            try {
                $masterConn.close()
            }
            catch {
            }
            Throw "$errMessage"
        }
        Write-Verbose (('Restore database {0} from {1}') -f $database, $backupFile)
        $masterConn.close()


    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }

}
