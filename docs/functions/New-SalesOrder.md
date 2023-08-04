---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-SalesOrder.md
schema: 2.0.0
---

# New-SalesOrder

## SYNOPSIS
Creates a new sales order

## SYNTAX

```
New-SalesOrder [[-invoiceAddressId] <Int32>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Based on the ID of the invoice recipient's address, an order header is created whose ID is returned as a function result. The connection to the database is opened by specifying a connection object. This can be a COM object, a connection string or a path specification of a UDL file.
The address, which is given with the ID, must contain a valid payment term. In case of a freshly installed database, the table `KonZiel` is preset with a payment target, which has the ID 1.

## EXAMPLES

### Example 1:Creates the order header
```powershell
PS C:\> [int]$salesOrderId= New-SalesOrder -invoiceAddressId 25 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

The function is passed the id of an existing address. This address is then the invoice recipient. The other parameter is the database connection. This is done in this example by a UDL file. After creating the header, the Id of the order header is returned as the function result. With this you can add fields to the header data via a further SQL update command. 
This ID is also needed to add positions to this order.

## PARAMETERS

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

### -invoiceAddressId
The Id of the billing address

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
