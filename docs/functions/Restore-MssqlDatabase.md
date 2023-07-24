---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Restore-MssqlDatabase.md
schema: 2.0.0
---

# Restore-MssqlDatabase

## SYNOPSIS
Restores a SQL Server database from a backup file.

## SYNTAX

```
Restore-MssqlDatabase [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Restore-MssqlDatabase function restores a SQL Server database from a backup file. It takes the connection information to the master database and the path to the backup file as input parameters. The function attempts to restore the specified database from the backup and handles errors during the restore process. After the restore is completed, the function verifies the success of the restore operation.

## EXAMPLES

### Example 1: Restore a SQL Server database using a UDL file.
```powershell
PS C:\> Restore-MssqlDatabse -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

Restores the database specified in the `Eulanda_1 JohnDoe.udl` file. The user specified in the UDL file must be in the sysadmin role to perform the restore function.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -connStr
A `ConnectionString` can be specified here, with which a database can be opened.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -udl
Alternatively to a connection, a string to a UDL file can be specified. In this case an ADO object is created and closed again at the end of the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

This function requires the SQL Server module and relies on the `Get-Conn` function to establish a connection to the SQL Server instance. It is recommended to have sysadmin rights on the SQL Server instance to perform database restores. 

## RELATED LINKS

Backup-MssqlDatabase
