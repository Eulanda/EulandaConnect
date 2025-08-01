---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-PurchaseOrderLineItem.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-PurchaseOrderLineItem

## SYNOPSIS
Creates a new purchase order line item in the database by calling the stored procedure.

## SYNTAX

```
New-PurchaseOrderLineItem [[-purchaseOrderId] <Int32>] [[-purchaseOrderNo] <Int32>] [[-barcode] <String>]
 [[-articleNo] <String>] [[-articleId] <Int32>] [[-articleUid] <Guid>] [[-quantity] <Decimal>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `New-PurchaseOrderLineItem` function creates a new purchase order line item in the database.  It first validates the provided purchase order ID and article ID.  It then calls a stored procedure to create the line item, passing the necessary parameters such as quantity.  Finally, it returns the ID of the newly created line item. 

## EXAMPLES

### Example 1: Inserts a new line item to a purchase order
```powershell
PS C:\> $purchaseOrderId = 123
PS C:\> $articleId = 456
PS C:\> $quantity = 3.5
PS C:\> $Id = New-PurchaseOrderLineItem -purchaseOrderId $purchaseOrderId -articleId $articleId -quantity $quantity
```

In this example, a new line item is added to the purchase order with ID 123. The line item is for the article with ID 456, and the quantity is 3.5. The function returns the ID of the newly created line item.

## PARAMETERS

### -articleId
The `ArticleId` is a unique key in the table. It is normally only used internally to link tables together.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -articleNo
The `ArticleNo` is a unique alphanumeric field in the ERP system. If the value is set, then the article is searched by this number.

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

### -articleUid
A UID (Unique Identifier) is a unique identifier assigned to a specific record in a database. In the context of EULANDA ERP software, each article is assigned a UID to uniquely identify it, regardless of its name, number, or other properties. The UID is usually automatically generated by the database and has a fixed length and formatting to ensure its uniqueness. The `articleUid` parameter is used to specify the UID of the article to retrieve the record.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -barcode
The barcode (= GTIN) is a field in the article table which is not defined as a unique field by default. However, if you want to achieve a reliable search, the field should be set to uniqueness in the database beforehand.

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

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchaseOrderId
The ID of the purchase order that the line item is associated with.  This or `-purchaseOrderNo` must be passed.

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

### -purchaseOrderNo
The number of the purchase order. This or `-purchaseOrderId` must be passed.

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

### -quantity
The quantity of the article in the line item. 

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 8
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


