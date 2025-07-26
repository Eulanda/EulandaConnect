---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-ShopExtension.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-ShopExtension

## SYNOPSIS
Tests whether the Shop extension is installed in the EULANDA ERP software by checking the existence of the `esolArtikelShop` table in the SQL database.

## SYNTAX

```
Test-ShopExtension [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Test-ShopExtension` function checks whether the Shop extension is installed in the EULANDA ERP software by connecting to the SQL database and querying the existence of the `esolArtikelShop` table. If the table exists, the extension is installed; otherwise, it is not.

## EXAMPLES

### Example 1
```powershell
PS C:\> [bool]$ShopInstalled= Test-ShopExtension -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

Tests whether the Shop extension is installed in the SQL Server using the UDL file located at `C:\temp\Eulanda_1 JohnDoe.udl`.

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

### System.Boolean
## NOTES

## RELATED LINKS


