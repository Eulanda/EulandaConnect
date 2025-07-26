---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Set-DeliveryQty.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Set-DeliveryQty

## SYNOPSIS
Change the delivery quantities

## SYNTAX

```
Set-DeliveryQty [[-quantities] <Array>] [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>]
 [[-bookingInfo] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function is special because it can change several delivery quantities in one even already booked delivery bill. This option has only recently become available. In this case, the delivery bill is briefly set to the `Capture` mode. The associated order is also modified, as are the stock journals. Afterwards, the entire chain involved is closed again. If the changed delivery bill is to be closed as well, `Close-Delivery` must be called explicitly. After changing the quantities, the delivery bill is closed in any case.

> Via specific extensions (= customizing), delivery bills can be automatically transmitted electronically to a logistics provider during posting. When changing the quantities at this point, this delivery bill is of course not transmitted again.

**When is something like this needed?** 
For example, when working with external warehouses, such as logistics companies. The delivery bill is sent as a delivery order to the logistician, but for some reason not enough goods are available. In this case, a correction of the delivery bill can be made from such a feedback, without the need for a cancellation with complete re-creation. The delivery note keeps the same ID and the process can be mapped cleanly.

> This function is based on a strongly extended SQL-API within EULANDA and requires version **8.5.58 or newer** of the ERP system.  If this function is called in older systems, unwanted effects will occur.

## EXAMPLES

### Example 1:Change to line Items in a delivery note (dynamic)
```powershell
# Dynamic filling of the structure e.g. with lists
$quantities = @()

# First article quantity to change
$hash = @{}
$hash['articleNo'] = '4711'
$hash['qty'] = 5
$quantities += $hash

# Second article quantity to change
$hash = @{}
$hash['articleNo'] = '0815'
$hash['qty'] = 3
$quantities += $hash

# Change the quantities in absolute
Set-DeliveryQty -quantities $quantities -deliveryNo 430220 -bookingInfo "CONFIRM 1Z5468131" -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

This example refers to a fictitious delivery bill with the number `430220`. It contains at least two line items, one with the article number `4711` and one with the article number `0815`. The line item with the article `4711` must contain a quantity greater than `5` and the line item with the article `0815` must contain a quantity greater than `3`.

The quantity object passed is an array containing two hash tables. Each hash table consists of a pair of item number and quantity. The quantity is then the new quantity of the delivery bill line item.

The posting text for the necessary correction postings in the warehouse journal should be short and contain a reference to the forwarding message.

The database is specified here via a UDL file, but it is also possible to pass the ADO connection object or a connection string directly.

### Example 2:Change to line Items in a delivery note (static)

```powershell
# Static specification of the structure
$quantities =@(@{articleNo='4711'; qty=5}, @{articleNo='0815'; qty=3})

# Change the quantities in absolute
Set-DeliveryQty -quantities $quantities -deliveryNo 430220 -bookingInfo "CONFIRM 1Z5468131" -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

The same happens as in example one, except that the array is filled statically here - the effect is absolutely identical.

## PARAMETERS

### -bookingInfo
The transfer postings provide warehouse journals with adjustment postings. Here you can specify a short text that will be stored in these entries.

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

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 6
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
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -quantities
The passed quantity object is an array containing hash tables. Each hash table consists of a pair of 'articleNo 'and 'qty'.

```yaml
Type: Array
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
Position: 5
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


