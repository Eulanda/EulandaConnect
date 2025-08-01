---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-Delivery.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-Delivery

## SYNOPSIS
Creates a delivery bill based on a sales order

## SYNTAX

```
New-Delivery [[-salesOrderNo] <Int32>] [[-salesOrderId] <Int32>] [[-customerOrderNo] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This will create a delivery bill. The sales order ID of a completed, i.e. booked order is transferred. In addition, a connection to the ERP database is required. As a result, all deliverable order items are transferred to a delivery bill. The function returns the new delivery bill Id as a result.

## EXAMPLES

### Example 1:Converts an order into a delivery bill and returns its Id
```powershell
PS C:\> [int]$deliveryId
PS C:\> $deliveryId= New-Delivery -salesOrderId 25 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

Here the 25 and a UDL file are transferred as sales order ID. In this case, the order is completely booked into a delivery bill, if the stock level permits this. The new delivery bill ID is returned as the function result.

> If you switch off the warehouse management completely or for certain articles in the ERP system, no warehouse check is carried out.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerOrderNo
This is the customer's order number. It is typically passed from an external system, such as an online shop system, to the ERP (Enterprise Resource Planning) system as a unique reference. It should be noted that this value is not defined as unique in the ERP system's database itself.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesOrderId
The `SalesOrderId` is the `ID` of the header record of the sales order. The `ID` is always unique throughout the table.

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

### -salesOrderNo
The `SalesOrderNo` is the userfriendly `number` of the header record of the sales order. The `number` is always unique throughout the table. Only one of the parameters can be specified, either -salesOrderId or -salesOrderNo.

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
Position: 4
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


