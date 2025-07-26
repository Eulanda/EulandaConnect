---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-PurchaseOrder.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-PurchaseOrder

## SYNOPSIS
The New-PurchaseOrder function creates a new purchase order for a specific supplier in the database.

## SYNTAX

```
New-PurchaseOrder [[-supplierID] <Int32>] [[-processedBy] <String>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function takes a supplier ID and the name of the user who processes the order. It then calls a stored procedure "[dbo].[cn_KfNew]"     to create a new purchase order. The stored procedure generates a new purchase order ID, which is returned by the function.    Afterwards, the function retrieves a new purchase order number from a number series and updates the newly created purchase order     with this number. 

## EXAMPLES

### Example 1: Creates a new purchase order for a given supplier Id
```powershell
PS C:\> $Id = New-PurchaseOrder -supplierID 123 -processedBy "John Doe" -udl 'C:\temp\Eulanda_1 JohnDow.udl'
```

This will create a new purchase order for the supplier with the ID 123. The order will be processed by John Doe. 

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

### -processedBy
The name of the user who processes the order.

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

### -supplierID
The ID of the supplier for which the purchase order is to be created.

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

This function requires an ADODB connection to the database. It can either be passed directly via the 'conn' parameter, or indirectly via a UDL file or a connection string.

## RELATED LINKS


