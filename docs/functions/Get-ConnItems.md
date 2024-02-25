---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ConnItems.md
schema: 2.0.0
---

# Get-ConnItems

## SYNOPSIS
This PowerShell function returns all value pairs as a hash table. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-ConnItems.ps1).

## SYNTAX

```
Get-ConnItems [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function returns a hash table with the values of the Connection object. Alternatively, a UDL file or a connection string can be specified. The individual values are then accessed by specifying the individual value names. The individual value pairs are especially needed for SQL access via the PowerShell module `ImportExcel`, but can also be useful in other ways.

## EXAMPLES

### Example 1:Returns the value pairs of a connection as hash table
```powershell
PS C:\> [hashtable]$params = Get-ConnItems -udl "C:\temp\Eulanda_1 JohnDoe.udl"
PS C:\> Write-Host $params['Initial Catalog']

# Result is shown on the display
Eulanda_JohnDoe
```

```ini
[oledb]
; Everything after this line is an OLE DB initstring
Provider=SQLOLEDB.1;Data Source=.\EULANDA;USER ID=eulanda;PASSWORD=NoIdea;Initial Catalog=Eulanda_JohnDoe;Persist Security Info=True
```

Returns a hash table with all value pairs that can be determined from the UDL file. It is now very easy to access each element. These parameters are needed for the Excel module `ImportExcel`. The second block shows the content of the UDL file.

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

[Get-Conn](../functions/Get-Conn.md)




