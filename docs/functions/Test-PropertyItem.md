---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-PropertyItem.md
schema: 2.0.0
---

# Test-PropertyItem

## SYNOPSIS
Checks if there is an entry in the property tree for a specific record.

## SYNTAX

```
Test-PropertyItem [[-id] <Int32>] [[-propertyId] <Int32>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
If the property is set for a specific table, such as article or delivery bill, the function returns true, otherwise false. The record itself is specified by its ID, e.g. the articleId. The -propertyId is displayed in the ERP system, in the tree property via the right mouse button.

## EXAMPLES

### Example 1:How a property tree looks like
```ini
Articles/
├─ My Properties/
├─ Shop Catalog/
│  ├─ Hardware
│  ├─ Software
│  ├─ Books
├─ Colors/
│  ├─ Red
│  ├─ Green
│  ├─ Blue
├─ Special Flag
```

This property tree is only an example. Based on this structure, all articles for example assigned to this property can be displayed immediately in the ERP system, so it is a kind of filter. However, these filters can also be used when printing, exporting or displaying a product online, or where ever a property is set.

Setting these properties can be done manually or through this API. For example, it can be determined whether an article should be transferred to an online store system or not.

### Example 2: Checks if an recordshas a certain property
```powershell
PS C:\> [bool]$blue = (Test-PropertyItem -id 3623 -propertyId 125 -udl "C:\temp\Eulanda_1 JohnDoe.udl")
```

Here it is checked whether the record has the color blue or not. The ID for the blue property must be looked up in the ERP system beforehand.
In this way, each article can be checked for this property. The database is accessed by specifying the UDL file.

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
The `id` is a unique key in the table. It is normally only used internally to link tables together. The tablename is just assigned before.

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
