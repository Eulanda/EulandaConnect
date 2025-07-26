---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Set-StockQty.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Set-StockQty

## SYNOPSIS
Changes the stock quantity of items

## SYNTAX

```
Set-StockQty [[-quantities] <Array>] [[-stockGroup] <Int32>] [[-bookingInfo] <String>] [-throwOnError]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The stock of several articles can be set to a **new absolute value** using this function. By specifying a warehouse account, either the standard warehouse `1000` or one of the additional warehouses can be addressed.

In the latter case, the multi-warehouse system must be activated in the ERP software so that the accounts up to and including account `1399` can be addressed.

At the end of the posting, a warehouse document is created for which a posting text can be specified. The booking information is specified via the parameter `bookingInfo`.

The connection to the SQL database is done via a connection object, a connection string or the specification of a UDL file.

The quantities and article numbers are passed via an array parameter, which contains hash table pairs as elements. Each of these hash tables contains a pair of `articleNo` and `qty`.

This function does not allow the addition of articles that have a serial number or the batch numbers.

## EXAMPLES

### Example 1:Change stock quantity absolutely for different articles
```powershell
# Dynamic filling of the structure e.g. with lists
PS C:\> $quantities = @()

# First article quantity to change
PS C:\> $hash = @{}
PS C:\> $hash['articleNo'] = '4711'
PS C:\> $hash['qty'] = 5
PS C:\> $quantities += $hash

# Second article quantity to change
PS C:\> $hash = @{}
PS C:\> $hash['articleNo'] = '0815'
PS C:\> $hash['qty'] = 3
PS C:\> $quantities += $hash

# Change the quantities in absolute
PS C:\> Set-StockQty -quantities $quantities -stockGroup 1000 -bookingInfo "Interim inventory" -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

In this example the quantity array is filled programmatically. Here, for example, a CSV file with inventory data could be processed, whereby a hashtable pair is added to the array line by line.
The standard warehouse is addressed by the warehouse group `1000`. The posting text should be short but still meaningful. The connection to the SQL database is done here via a UDL file. Keep in mind that you could also pass a connection string or an already instantiated ADO connection object instead.

## PARAMETERS

### -bookingInfo
The transfer postings provide warehouse journals with adjustment postings. Here you can specify a short text that will be stored in these entries.

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

### -stockGroup
Stockgroup is the account number of the storage location. It is in the range of 1000-1399 in the warehouse management system of the ERP system.

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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -throwOnError
If an article is not found, normally no exception is generated, but if the parameter is active, a corresponding exception is generated.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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


