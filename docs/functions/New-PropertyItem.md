---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-PropertyItem.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-PropertyItem

## SYNOPSIS
Creates a new entry for a property of a record.

## SYNTAX

```
New-PropertyItem [[-id] <Int32>] [[-propertyId] <Int32>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
In the ERP system, you can set any property for any data object, including a delivery bill. Properties can be stored in structures similar to a tree. A delivery bill can exist in any properties of the tree. Thus, the property also has an ID, the property ID. 
This function can be used to set for example a property to a delivery bill specified by its id. The connection to the database can be done either by a connection object, a connection string or the specification of a UDL file.

You can see what a property tree looks like in Example 1.

## EXAMPLES

### Example 1: How a property tree looks like
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
Setting these properties can be done via this API. For example, when the tracking data is delivered by the shipping company and imported by a module. For example, if all shipments have tracking, the property `Complete` is set.

### Example 2:New Property Item for a Delivery Note
```powershell
PS C:\> New-DeliveryPropertyItem -id 56500 -propertyId 125 -deliveryNo 20230515  -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

This function sets the property, which internally has the Id 125 and the records with the Id 56500 of the delivery bill. The database is specified via a UDL file.
The property ID is determined directly in the ERP system by clicking on the property name with the right mouse button and noting the displayed ID.

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
A ConnectionString can be specified here, with which a database can be opened.

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

### -id
The Id of the records like articleId or deliveryId etc. This Id is always related by the propertyId.

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

### -propertyId
The property ID is determined directly in the ERP system by clicking on the property name with the right mouse button and noting the displayed ID.

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


