---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-SalesOrder.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-SalesOrder

## SYNOPSIS
Checks the customer order number to see if the order already exists.

## SYNTAX

```
Test-SalesOrder [[-salesOrderNo] <Int32>] [[-salesOrderId] <Int32>] [[-customerOrderNo] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The customer order number is used to check whether the sales order already exists. 
Usually this field is used to import orders from external systems, such as an online store system. A check can be used to prevent the same order from being created a second time. Ideally, this field can be marked as unique in the ERP database beforehand.

## EXAMPLES

### Example 1:Checks if a sales order for the customer order number already exists
```powershell
PS C:\> [bool]$orderExists= (Test-SalesOrder -customerOrderNo 5025  -udl "C:\temp\Eulanda_1 JohnDoe.udl")
```

The function returns true if the order with customer order number 5025 already exists. The SQL database is accessed via a UDL file. Alternatively, an ADO connection object or a connection string are also possible.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type `ADODB.Connection`. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

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
A ConnectionString can be specified here, with which a database can be opened.

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


