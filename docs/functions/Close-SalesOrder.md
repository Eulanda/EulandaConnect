---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Close-SalesOrder.md
schema: 2.0.0
---

# Close-SalesOrder

## SYNOPSIS
This PowerShell function closes a sales order, it is considered completed and can no longer be modified. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Close-SalesOrder.ps1).

## SYNTAX

```
Close-SalesOrder [[-salesOrderNo] <Int32>] [[-salesOrderId] <Int32>] [[-customerOrderNo] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
After the sales order is closed, it is kept as an open order in ERP and, for example, displayed as an order in the brief information system at the customer's site. Orders with this status can no longer be changed.

## EXAMPLES

### Example 1:Close Sales Order with Id 25
```powershell
PS C:\> Close-SalesOrder -salesOrderId 25 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

This closes the sales order specified by its Id=25 and the database connection to the UDL file.

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
The `SalesOrderId` is the `ID` of the header record of the sales order. The `ID` is always unique throughout the table. Only one of the parameters can be specified, either -salesOrderId or -salesOrderNo.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Close-SalesOrder.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Close-SalesOrder.ps1)
