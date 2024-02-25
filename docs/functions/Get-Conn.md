---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Conn.md
schema: 2.0.0
---

# Get-Conn

## SYNOPSIS
This PowerShell function returns an open connection to a EULANDA database. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-Conn.ps1).

## SYNTAX

```
Get-Conn [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function returns an opened Connection object. If a connection is already passed as input parameter, it will be used. If it was closed, it will be opened automatically. Alternatively a UDL file or a Connection-String can be specified to access the database.

## EXAMPLES

### Example 1:Returns an opened connection object
```powershell
PS C:\> $conn = Get-Conn -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

Based on a UDL file, an opened Connection object is returned and assigned to the `$conn` variable. This can then be used to make many other calls by continuing to use the same connection.

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

## RELATED LINKS

[Get-ConnItems](./functions/Get-ConnItems.md)





