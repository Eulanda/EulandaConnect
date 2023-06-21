---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Export-DeliveryToXml.md
schema: 2.0.0
---

# Export-DeliveryToXml

## SYNOPSIS
Exports a delivery bill including its positions to an XML file

## SYNTAX

```
Export-DeliveryToXml [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [-includeEmpty] [[-sql] <String[]>]
 [[-path] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The delivery note to be exported is selected either by the ID or the delivery note number. You can specify the XML root node via $root. Additionally $arrRoot can be specified. The positions are then appended to this.

## EXAMPLES

### EXAMPLE 1:Exports a delivery bill as an xml file.
```powershell
PS C:\> Export-DeliveryToXml -deliveryNo 430220 -includeEmpty -path "C:\Temp\Result.xml"
```

This operation creates an XML output containing the details of a specific delivery note, including its associated header and line items. the metadata and the EULANDA root. Because the switch `-includeEmpty` was set, also empty fields were exported. An example of an export can be found under [XML Delivery Note](../appendix/XmlDeliveryNote.md).

## PARAMETERS

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
A `ConnectionString` can be specified here, with which a database can be opened.

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
Position: 0
Default value: 0
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
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeEmpty
Normally, empty nodes or nodes with a value of null are not exported. This switch allows for exporting of these nodes as well.

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

### -path
A path is a combination of the drive letter, share, subfolders, and the filename of the resource, for example, a XML file.

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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
