---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DeliveryQty.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-DeliveryQty

## SYNOPSIS
Returns a hashtable with the delivery quantities of the positions

## SYNTAX

```
Get-DeliveryQty [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
For a delivery note number, all quantities of the delivery note items are output in the form of a hash table. The key of the hash table is the field `articleNo`, which however corresponds with the database field `barcode`. All positions of the delivery bill, which possibly contain the same key field, in this case the field `barcode`, are **summarized**. 

## EXAMPLES

### Example 1:Returns a hashlist with all cumulated line items of a delivery note
```powershell
PS C:\> [hashtable]$qty = Get-DeliveryQty -deliveryNo 430220 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

For delivery note number `430220`, the quantities of all items are returned in a hash table. The key here is the respective article number. In this example, the database is accessed by specifying a UDL file.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deliveryId
The delivery note is searched for by its ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deliveryNo
The delivery note is found via its delivery note number.

```yaml
Type: Int32
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


