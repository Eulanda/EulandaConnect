---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaDelivery.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-XmlEulandaDelivery

## SYNOPSIS
Generates an XML output for the specified delivery note, including the line items.

## SYNTAX

```
Get-XmlEulandaDelivery [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [-includeEmpty] [[-sql] <String[]>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This operation generates an XML output containing the details of a specific delivery note, along with its associated line items. The generated XML output can be used for data exchange, reporting, or further processing.

The SQL array specifies the SQL SELECT statement for the database query. The first array element is for the master (delivery note header), and the second array element is for the details (delivery note line items). The array is pre-populated and is generated internally by the `Get-DeliverySql` function.

> If you want to use a different SELECT statement with different fields or field names, you can derive it by wrapping the respective SQL command in a nested SELECT statement. It is important to note that the output is sorted based on the first specified field.

## EXAMPLES

### Example 1:Generates an XML output for a delivery note.
```powershell
PS C:\> Get-XmlEulandaDelivery -DeliveryNo 430952 -Udl 'C:\Temp\Eulanda_1 JohnDoe.udl'
```

This operation creates an XML output containing the details of a specific delivery note, including its associated header and line items. The generated XML output is used inside `Export-DeliveryToXml`. Because the switch `-includeEmpty` was set, also empty fields were exported.

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

### -includeEmpty
An optional switch specifying whether empty values should be included in the output. If this switch is provided, empty values will be used in the output; otherwise, default values will be used.

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

### -sql
This string array is pre-populated by default with an SQL SELECT statement for the delivery note and the delivery note position, so it does not need to be specified. However, if you want to include a field selection or new fields, such as calculated or combined fields, in the XML, you can specify this SQL statement here as an array. The first element is the master, which is the delivery note header, and the second array element is the SELECT statement to select the corresponding positions. The positions are implicitly sorted by the first field of the position, which is normally the delivery note position. The field name is then ID.ALIAS.

```yaml
Type: String[]
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


