---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-DeliveryPropertyItem.md
schema: 2.0.0
---

# Remove-DeliveryPropertyItem

## SYNOPSIS
Removes the delivery bill from the properties list

## SYNTAX

```
Remove-DeliveryPropertyItem [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-propertyId] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
In the ERP system, you can remove a property for a delivery bill. The delivery bill is specified either by its delivery note number or its ID. The connection to the database is made via a connection object, a connection string or the specification of a UDL file.

You can see what a property tree looks like in Example 1.

## EXAMPLES

### Example 1:How a property tree looks like
```ini
Delivery Notes/
├─ My Properties/
├─ Delivery Status/
│  ├─ Complete
│  ├─ Over Delivered
│  ├─ Under Delivered
├─ Tracking Information/
│  ├─ Partial Missing
│  ├─ Complete
│  ├─ All Missing
├─ Locked for Retransmission
```

This property tree is just an example. Using this structure, all delivery bills that are assigned to this property can be displayed immediately in the ERP system.
Removing these properties can be done via this API. 

### Example 2:Removes a property with the specified propertyId from the delivery bill
```powershell
PS C:\> Remove-DeliveryPropertyItem -propertyId 125 -deliveryNo 20230515  -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

In this example, the property with id 25 is removed from the property tree for the delivery bill with number 20230515. The connection to the database is made via the specified UDL file.

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

### -propertyId
The property ID is determined directly in the ERP system by clicking on the property name with the right mouse button and noting the displayed ID.

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
