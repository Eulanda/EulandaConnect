---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ConnStr.md
schema: 2.0.0
---

# Get-ConnStr

## SYNOPSIS
This PowerShell function creates a connection string based on the specified parameters. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-ConnStr.ps1).

## SYNTAX

```
Get-ConnStr [[-database] <String>] [[-server] <String>] [[-user] <String>] [[-password] <String>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The name of the database must be specified. This is used, no matter which method is used for the authentication. This makes it possible, for example, to use a UDL file but with a different database. The prerequisite is always that the user also has the authorization for this database.

The function allows to specify all parameters individually, to use an existing connection, a connection string or a UDL file. If the parameters are specified individually, the server name is sufficient in the simplest case. The logged-in Windows user is then used as the user.

## EXAMPLES

### Example 1:Returns a connection string for the master database
```powershell
PS C:\> $connStr= Get-ConnStr -database 'Master' -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

In this example, the server name and authentication from the UDL file are used. `Master` is used as the database. Important here, the authorization used in the UDL file must also be sufficient for access to the `Master` database.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -connStr
A ConnectionString can be specified here, with which a database can be opened.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -database
The name of the database to connect to.

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
The password to be connected to the database. In any case, this also includes the user name.

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

### -server
The name of the MSSQL server. This can also contain the instance name. If one is used, it must be specified with backslah. The name of the server can also be an IP address like 192.168.178.20. If a server is specified, the UDL, Conn and ConnStr parameters are ignored. If the server name is used, there are two methods, Windows authentication and SQL authentication. In the first variant, the user name and password are omitted. The logged-in user is then used.

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

### -udl
Alternatively to a connection, a string to a UDL file can be specified. In this case an ADO object is created and closed again at the end of the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -user
If the user is specified, a password is also required. SQL authentication is used as authentication and a server name is expected.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
