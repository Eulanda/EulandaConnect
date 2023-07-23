function Rename-MssqlDatabase {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$oldName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'oldName', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$newName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'newName', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'dbId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newLogicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newLogicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newPhysicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newPhysicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldLogicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldLogicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPhysicalLdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'oldPhysicalMdf' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsConn' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $paramsConn = Get-UsedParameters -validParams (@('server','user','password')) -boundParams $PSBoundParameters
        $paramsConn.Add('database','Master')

         # Initialize connection and command objects
        $myConn= Get-Conn -connStr (New-ConnStr @paramsConn)

        [string]$sql = "SELECT  DB_ID('$oldName') [DbId]"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [int]$dbId= $rs.fields('DbId').value
            if (! $dbId) { throw ((Get-ResStr 'RENAMEDB_ERROR_NO_DBID') -f $oldName) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get path the logical file names
        [string]$sql = "SELECT name FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.mdf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldLogicalMdf= $rs.fields('name').value
            if (! $oldLogicalMdf) { throw ((Get-ResStr 'RENAMEDB_NO_LOGICAL_MDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        [string]$sql = "SELECT name FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.ldf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldLogicalLdf= $rs.fields('name').value
            if (! $oldLogicalLdf) { throw ((Get-ResStr 'RENAMEDB_NO_LOGICAL_LDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get path the physical file names
        [string]$sql = "SELECT filename FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.mdf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldPhysicalMdf= $rs.fields('filename').value
            if (! $oldPhysicalMdf) { throw ((Get-ResStr 'RENAMEDB_NO_PHYSICAL_MDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        [string]$sql = "SELECT filename FROM sys.sysaltfiles WHERE dbid = $dbId and filename like N'%.ldf'"
        $rs = Get-AdoRs -recordset $myConn.Execute($sql)
        if ($rs) {
            [string]$oldPhysicalLdf= $rs.fields('filename').value
            if (! $oldPhysicalLdf) { throw ((Get-ResStr 'RENAMEDB_NO_PHYSICAL_LDF_PATH') -f $myInvocation.Mycommand) }
        } else { throw ((Get-ResStr 'ADO_NO_VALID_RECORDSET') -f $myInvocation.Mycommand) }

        # Get the path from the data folder and the names from the MDF and LDF file
        [string]$path = Split-Path $oldPhysicalMdf
        $oldPhysicalMdf = Split-Path $oldPhysicalMdf -Leaf
        $oldPhysicalLdf = Split-Path $oldPhysicalLdf -Leaf

        # Rename the database, to do this log out all logged in users by putting
        # the database into single user mode
        [string]$sql =  `
            "ALTER DATABASE [$oldName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE", `
            "ALTER DATABASE [$oldName] MODIFY NAME = [$newName]", `
            "ALTER DATABASE [$newName] SET MULTI_USER"
        $myConn.Execute($sql) | Out-Null

        # Build the new logical filenames
        [string]$newLogicalMdf = $newName
        [string]$newLogicalLdf = $newName + "_Log"

        # Build the new physical filenames
        [string]$newPhysicalMdf = $newName + ".mdf"
        [string]$newPhysicalLdf = $newName + "_log.ldf"

        # Rename the logical file names, this is only possible under their new name,
        # then take them offline to rename the files in the file system as well
        [string]$sql =  `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$oldLogicalMdf], NEWNAME = [$newLogicalMdf])", `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$oldLogicalLdf], NEWNAME = [$newLogicalLdf])", `
            "ALTER DATABASE [$newName] SET offline"
        $myConn.Execute($sql) | Out-Null

        # Prepare sql server for xp_cmdshell
        [string]$sql = `
            "EXEC sp_configure 'show advanced options', 1", `
            "RECONFIGURE", `
            "EXEC sp_configure 'xp_cmdshell', 1", `
            "RECONFIGURE"
        $myConn.Execute($sql) | Out-Null

        # Calls to the sql command shell to rename the file to the new file
        [string]$sql =  `
            "EXEC master..xp_cmdshell 'RENAME ""$path\$oldPhysicalMdf"" ""$newPhysicalMdf""'", `
            "EXEC master..xp_cmdshell 'RENAME ""$path\$oldPhysicalLdf"" ""$newPhysicalLdf""'"
        $myConn.Execute($sql) | Out-Null

        # Makes the new physical files for the database known and puts the DB back online
        [string]$sql =  `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$newLogicalMdf], FILENAME = '$path\$newPhysicalMdf')", `
            "ALTER DATABASE [$newName] MODIFY FILE (NAME = [$newLogicalLdf], FILENAME = '$path\$newPhysicalLdf')", `
            "ALTER DATABASE [$newName] SET online"
        $myConn.Execute($sql) | Out-Null

        $myConn.Close()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Rename-MssqlDatabase -oldName 'Eulanda_Pester' -newName 'Eulanda_PesterNew' -server ".\PESTER"
}
