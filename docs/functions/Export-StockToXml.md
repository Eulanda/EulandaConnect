---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Export-StockToXml.md
schema: 2.0.0
---

# Export-StockToXml

## SYNOPSIS
Exports the stock level to an XML file

## SYNTAX

```
Export-StockToXml [[-filter] <String[]>] [[-alias] <String>] [[-qtyStatic] <Int32>] [[-warehouse] <String>]
 [-legacy] [[-path] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The quantities of individual warehouses can be exported individually or as a whole. In addition to your own warehouses, you can also export the stock levels of suppliers warehouses as an XML file.

## EXAMPLES

### EXAMPLE 1:Exports the quantities of the CHICAGO warehouse to an XML file
```powershell
PS C:\> Export-StockToXml -path "C:\Temp\Stock.xml" -udl "C:\temp\Eulanda_1 JohnDoe.udl" -filter @("Barcode >= '1000000'", "Barcode <= '8888889'") -alias 'BARCODE' -warehouse 'CHICAGO'
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<EULANDA>
  <METADATA>
    <VERSION>1.22</VERSION>
    <GENERATOR>EulandaConnect</GENERATOR>
    <DATEFORMAT>ISO8601</DATEFORMAT>
    <FLOATFORMAT>US</FLOATFORMAT>
    <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
    <FIELDNAMES>NATIVE</FIELDNAMES>
    <DATE>2023-02-13T09:44:46</DATE>
    <PCNAME>SURFACE</PCNAME>
    <USERNAME>JD</USERNAME>
  </METADATA>
  <ARTIKELLISTE>
    <ARTIKEL>
      <ID.ALIAS>3102069</ID.ALIAS>
      <LAGER>
        <BESTANDVERFUEGBAR>5500.0000</BESTANDVERFUEGBAR>
      </LAGER>
    </ARTIKEL>
    <ARTIKEL>
      <ID.ALIAS>3102070</ID.ALIAS>
      <LAGER>
        <BESTANDVERFUEGBAR>57100.0000</BESTANDVERFUEGBAR>
      </LAGER>
    </ARTIKEL>
    <ARTIKEL>
      <ID.ALIAS>3102071</ID.ALIAS>
      <LAGER>
        <BESTANDVERFUEGBAR>16100.0000</BESTANDVERFUEGBAR>
      </LAGER>
    </ARTIKEL>
    <ARTIKEL>
      <ID.ALIAS>3102113</ID.ALIAS>
      <LAGER>
        <BESTANDVERFUEGBAR>31538.0000</BESTANDVERFUEGBAR>
      </LAGER>
    </ARTIKEL>
  </ARTIKELLISTE>
</EULANDA>
```

## PARAMETERS

### -alias
Historically, the article number is always used as the unique field. However, there are other unique fields in the article table such as the `ID` and the `UID`. In addition, the barcode can be such a field, if this is changed user-specifically to uniqueness in the database. The XML file always contains `ID.ALIAS` as field name, but now related to one of the new possible field names. Allowed values are: `ID`, `UID`, `ARTNUMBER` and `BARCODE`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 5
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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
The filters are passed as an array of strings and refer to the native field names of the article table. They can contain single logical operators in PowerShell syntax. All filters are joined by logical AND. So the result set becomes smaller with the number of filters.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -legacy
Historically, three fields are always output during warehouse data transfer as xml file. One that contains the total stock of all warehouses, one that lists this quantity minus all sales orders and one that also takes into account the purchase orders. If, for example, only one storage location is to be output, the other two values are also output if the legacy switch is activated; in this case, however, always with the same stock level.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qtyStatic
Regardless of the actual stock quantities, this can be overwritten by a static specification. All outputs will then contain this static value. The idea behind this is that you can transmit stock figures to an online store in this way, for example, so that you can place and test orders in the store even without stock.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
The name of the warehouse, which must be located in the account area 1000-1399 in inventory management.

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

### None. You cannot pipe objects
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
