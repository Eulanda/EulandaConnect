---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-SalesOrderId.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-SalesOrderId

## SYNOPSIS
Returns the `Id` for a sales order

## SYNTAX

```
Get-SalesOrderId [[-salesOrderNo] <Int32>] [[-salesOrderId] <Int32>] [[-customerOrderNo] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Based on a order no, the Id to a sales order is returned. The Id is used for various functions. Especially for linking tables. The database can be specified via a Connection object, a UDL file or a ConnectionString.

## EXAMPLES

### Example 1:Returns the Id of the specified sales order
```powershell
PS C:\> Get-SalesOrderId -salesOrderNo 20230515  -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

After executing the command, the function result returns the Id of the sales order to which the sales order number `20230515` belongs. The database is accessed by specifying a UDL file. Instead, an existing Connection object could also be specified.

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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


