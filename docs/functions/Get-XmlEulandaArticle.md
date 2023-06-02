---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaArticle.md
schema: 2.0.0
---

# Get-XmlEulandaArticle

## SYNOPSIS
Returns one or more articles as an XML fragment, allowing for filtering, sorting and reordering of the data.

## SYNTAX

```
Get-XmlEulandaArticle [[-select] <String>] [[-filter] <String[]>] [[-alias] <String>] [[-order] <String>]
 [-reorder] [-revers] [[-customerGroups] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-XmlEulandaArticle` function returns one or more articles as an XML fragment. A comma-separated list of fields can be specified with the `-select` parameter. By default, it uses a set of field names compatible with the classic EULANDA shop interface.

The `-filter` parameter can be used to specify an array of SQL filter conditions, which are combined with logical AND.

The `-alias` parameter is set to the article number (`articleNo`) by default, but it can be changed. The alias is output as the `ID.ALIAS` field name in the XML output.

The output can be sorted by a specific field name using the `-order` parameter. If nothing is specified, the field name of `-alias` is used for sorting.

The `-reorder` parameter can be used to specify a different order for field names (sorted alphabetically).

If the output of the datasets should be in reverse order, the `-reverse` switch can be used.

Subqueries for additional XML fragments are performed for each article. This way, shop extension fields, stock levels, price lists, and breadcrumb paths in which the respective article is contained are added.

The connection to the database is made via an ADO COM object, a connection string, or a UDL file.

The fragment is output as an XmlString.

## EXAMPLES

### Example 1:Single article fragment as an xmlString
```powershell
PS C:\> Get-XmlEulandaArticle -filter "ArtNummer='130100'" -udl 'C:\temp\Eulanda_1 Truccamo.udl'
```

```xml
<ARTIKELLISTE>
    <ARTIKEL>
        <ID.ALIAS>130100</ID.ALIAS>
        <ARTNUMMER>130100</ARTNUMMER>
        <CHANGEDATE>2023-03-26T15:33:43</CHANGEDATE>
        <ARTNUMMER>130100</ARTNUMMER>
        <BARCODE>4028362130100</BARCODE>
        <MWSTSATZ>22.00</MWSTSATZ>
        <MWSTGR>3</MWSTGR>
        <WAEHRUNG>EUR</WAEHRUNG>
        <GEWICHT>0.0000</GEWICHT>
        <SHOPEXPORTDATUM>2018-11-12T10:13:23</SHOPEXPORTDATUM>
        <SHOPFREIGABEFLG>True</SHOPFREIGABEFLG>
        <AUSLAUFFLG>False</AUSLAUFFLG>
        <NEUFLG>False</NEUFLG>
        <SONDERFLG>False</SONDERFLG>
        <LOESCHFLG>False</LOESCHFLG>
        <VERPACKEH>1.00</VERPACKEH>
        <PREISEH>1.00</PREISEH>
        <EKNETTO>2.16</EKNETTO>
        <VK>5.95</VK>
        <BRUTTOFLG>True</BRUTTOFLG>
        <VKNETTO>4.88</VKNETTO>
        <VKBRUTTO>5.95</VKBRUTTO>
        <LAGERTYP>17</LAGERTYP>
        <URSPRUNGSLAND>DE</URSPRUNGSLAND>
        <WARENNR>33049900</WARENNR>
        <VOLUMEN>0.0000</VOLUMEN>
        <KURZTEXT1>Profi-Aqua Perlglanz-Perlmutt, 12ml</KURZTEXT1>
        <KURZTEXT2>Madreperla perlato, 12ml</KURZTEXT2>
        <ULTRAKURZTEXT />
        <LANGTEXT>
            [DE:SHORT]
            Perlglanz Perlmutt - 12 ml
            [IT:SHORT]
            Brillante madreperla - 12 ml
            [EN:SHORT]
            Pearlised Pearl - 12 ml
            [DE]
            Profi-Aqua perlglanz perlmutt - 12 ml
            [IT]
            Profi-Acqua Brillante madreperla - 12 ml
            [EN]
            Profi-Aqua pearlised pearl - 12 ml
        </LANGTEXT>
        <INFO />
        <SHOP>
            <ARTICLETYPE>3</ARTICLETYPE>
            <MASTERARTICLE>350102-M</MASTERARTICLE>
            <METATITLE />
            <METADESCRIPTION />
            <METAKEYWORDS />
            <DIMENSIONHEIGHT />
            <DIMENSIONWIDTH />
            <DIMENSIONDEPTH />
            <INFOURLTEXT />
            <INFOURL />
            <IMAGE1 />
            <IMAGE2 />
            <IMAGE3 />
            <IMAGE4 />
            <IMAGE5 />
            <IMAGE6 />
            <IMAGE7 />
            <IMAGE8 />
            <IMAGE9 />
            <IMAGE10 />
            <IMAGE11 />
            <IMAGE12 />
            <IMAGE13 />
            <IMAGE14 />
            <IMAGE15 />
            <SUGGESTEDLISTPRICE />
            <VARIANTDIMENSIONS1 />
            <VARIANTDIMENSIONS2 />
            <VARIANTDIMENSIONS3 />
            <VARIANTDIMENSIONS4 />
            <VARIANTDIMENSIONS5 />
            <VARIANTVALUE1>12 ml</VARIANTVALUE1>
            <VARIANTVALUE2 />
            <VARIANTVALUE3 />
            <VARIANTVALUE4 />
            <VARIANTVALUE5 />
            <CROSS1 />
            <CROSS2 />
            <CROSS3 />
            <CROSS4 />
            <CROSS5 />
            <CROSS6 />
            <CROSS7 />
            <CROSS8 />
            <UP1>180105</UP1>
            <UP2>300107</UP2>
            <UP3>350102</UP3>
            <UP4>700105</UP4>
            <UP5 />
            <UP6 />
            <UP7 />
            <UP8 />
            <BASEDIVISOR>0.0000</BASEDIVISOR>
            <BASEUNIT />
            <SALESSIZE>12.0000</SALESSIZE>
            <SALESUNIT>100</SALESUNIT>
            <SHIPPINGWEIGHT />
            <SHIPPINGFREE />
            <VARIANTTEXT1>Size (ml)</VARIANTTEXT1>
            <VARIANTTEXT2 />
            <VARIANTTEXT3 />
            <VARIANTTEXT4 />
            <VARIANTTEXT5 />
            <MANUFACTURER>MYSPIEGEL NVK</MANUFACTURER>
        </SHOP>
        <LAGER>
            <BESTANDVERFUEGBAR>0.00</BESTANDVERFUEGBAR>
            <BESTANDVERFUEGBAR1>0.00</BESTANDVERFUEGBAR1>
            <BESTANDVERFUEGBAR2>0.00</BESTANDVERFUEGBAR2>
        </LAGER>
        <PREISLISTE>
            <PREIS>
                <NAME>Reseller</NAME>
                <WAEHRUNG>EUR</WAEHRUNG>
                <BRUTTOFLG>False</BRUTTOFLG>
                <STAFFEL>1</STAFFEL>
                <MENGEAB>1.00</MENGEAB>
                <VK>2.16</VK>
            </PREIS>
        </PREISLISTE>
        <MERKMALLISTE>
            <MERKMAL>
                <PFAD>\Profi-Aqua\Make-Up</PFAD>
            </MERKMAL>
        </MERKMALLISTE>
    </ARTIKEL>
</ARTIKELLISTE>
```

This function outputs an XML fragment of an article with various subnodes, which are also available as individual PowerShell commands. This XML corresponds to the structure of the original shop interface. In this case, the database is specified via a UDL file.

## PARAMETERS

### -alias
Specifies an alternate field name to use as the unique identifier for each record. This field is always output as 'ID.ALIAS' in the XML.

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

### -customerGroups
Specifies the customer groups to use for calculating customer-specific prices based on the discounts associated with the article's discount group and the specified customer groups. This can be a single group or a comma-separated list of groups.

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

### -filter
Specifies an array of SQL filter conditions to apply to the output. For example: `-filter "ArtNummer='130100'`. Only native database field names are allowed in the filter conditions.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
Specifies a field name to sort the output of the articles.

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

### -reorder
Rearranges the field names in alphabetical order.

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

### -revers
Reverses the order of the output records.

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

### -select
Specifies a comma-separated list of field names to include in the output. Also an `*` for all fields is possible.

```yaml
Type: String
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String
## NOTES

## RELATED LINKS
