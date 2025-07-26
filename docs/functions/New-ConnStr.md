---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-ConnStr.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-ConnStr

## SYNOPSIS
Creates a connection string for the OLE DB driver of the SQL server

## SYNTAX

```
New-ConnStr [[-database] <String>] [[-server] <String>] [[-user] <String>] [[-password] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Generates a connection string to access a MSSQL Server database using ADO. The 'Microsoft OLE DB Provider for SQL Server' is supported. Either Windows authentication or SQL authentication is used, depending on whether a username and password are provided. Without these two fields, Windows authentication is used, meaning the credentials of the logged-in user are employed.

## EXAMPLES

### Example 1:Generates a connection string based on the database and server instance.
```powershell
PS C:\>  New-ConnStr -database 'EULANDA_JohnDoe' -Server '.\SQL2019'
```

```ini
Provider=SQLOLEDB.1;Data Source=.\SQL2019;Initial Catalog=EULANDA_JohnDoe;Integrated Security=SSPI
```

In this example, using the database name 'EULANDA_JohnDoe' and the local server instance 'SQL2019', the above-mentioned connection string is generated.

## PARAMETERS

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


