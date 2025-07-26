---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-SupplierId.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-SupplierId

## SYNOPSIS
The provided function retrieves the SupplierId based on the -addressMatch of an address from the EULANDA ERP database.

## SYNTAX

```
Get-SupplierId [[-addressMatch] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Each supplier in the 'Kreditor' table has a special entry called `AdresseId` that links it to a specific address in the 'Adressen' table. This is how the program knows which supplier is associated with which address.

The `Get-SupplierId` function takes a `-addressMatch`, connects to the database, and looks up which supplier is associated with that address. It then gives you the ID of the supplier.

## EXAMPLES

### Example 1: Returns the supplierId for an addressMatch 'WUERTH'
```powershell
PS C:\> $id = Get-SupplierId -addressMatch 'WUERTH' -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

Returns the SupplierId for an address with the matchcode 'WUERTH'. It is important to note that the matchcode is searched in the address table and not in the linked supplier file.

## PARAMETERS

### -addressMatch
The parameter `-addressMatch` is a match code in the EULANDA ERP system, which also serves as a search term but as a unique search field. It is practical because it is easily readable and understandable, and is often used to compare data with external systems. The match code is used to search for a specific address, to ensure that the searched address is unique and valid.

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

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 3
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


