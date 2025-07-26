---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Rename-MssqlDatabase.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Rename-MssqlDatabase

## SYNOPSIS
Rename any MSSQL database including the logical, physical as well as the file names on the hard disk

## SYNTAX

```
Rename-MssqlDatabase [[-oldName] <String>] [[-newName] <String>] [[-server] <String>] [[-user] <String>]
 [[-password] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function renames any MSSQL database. This with inclusion of the logical- physical as well as the file names on the hard disk. 

The authorization to the SQL server can be done via the server name and optionally user name and password, and alternatively via a connection string, a UDL file or an already instantiated connection object.

The database name is specified via the `oldName` parameter and the new name via `newName`. 

Administrative rights on the SQL server are required to execute the function. During the conversion the database is set to single user operation. In case of errors the function generates an exception.

The function uses the ADO com object to establish the connection and is therefore specially designed for Windows systems.

## EXAMPLES

### Example 1:Renaming Database to EULANDA_Doe
```powershell
PS C:\> Rename-MssqlDatabase -oldName 'EULANDA_JohnDoe' -newName 'EULANDA_Doe' -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

In this example, the authentication to the SQL server is done via the UDL file. It does not matter whether the database to be renamed is specified in the UDL file. The only important thing here is that the server and, if applicable, the instance are specified here. Access is then either via user name with password, or via Windows authentication if user and password are not specified in the UDL file.
After execution of the function the database, which was called `EULANDA_JohnDoe` before, is renamed to `EULANDA_Doe`, incl. internal logical and physical names. The database files (MDF+LDF) on the hard disk are also renamed.

## PARAMETERS

### -newName
The new name of the MSSQL database. If it is a database of the EULANDA ERP system it must start with EULANDA_.

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

### -oldName
The existing name of the database to be changed in the name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
Connection to the MSSQL server can also be done via `server`, `user` and `password` if the server is set up for mixed authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -server
The name of the MSSQL server can be specified with its name or IP4 number. An instance name can also be specified via a backslash.

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

### -user
The user name for authentication to the MSSQL server. Here the SQL_Server must support the mixed authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

## RELATED LINKS


