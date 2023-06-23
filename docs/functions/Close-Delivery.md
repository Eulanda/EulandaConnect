---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Close-Delivery.md
schema: 2.0.0
---

# Close-Delivery

## SYNOPSIS
On closing the delivery quantities are debited from the warehouse

## SYNTAX

```
Close-Delivery [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
On the one hand, a delivery bill is write-protected when it is closed, and on the other hand, the delivery quantities are debited from the warehouse.

## EXAMPLES

### Example 1:Close the Delivery Note 202305230
```powershell
PS C:\> Close-Delivery -deliveryNo 202305230 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

This closes the delivery bill with the delivery bill number 202305230. The database, i.e. the client is specified in this example by a UDL file.

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
The `DeliveryId` is the `ID` of the header record of the delivery bill. The `ID` is always unique throughout the table.

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
The DeliveryNo is the delivery bill number of the record. It is the number used in the business correspondence and of course in the delivery bill itself. It is also unique.

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

### None. You cannot pipe objects

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Close-Delivery.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Close-Delivery.ps1)

[Open-Delivery](./Open-Delivery.md)
