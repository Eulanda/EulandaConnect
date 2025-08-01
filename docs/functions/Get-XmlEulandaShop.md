---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaShop.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-XmlEulandaShop

## SYNOPSIS
Get-XmlEulandaShop creates an XML fragment with details from the installed shop interface, such as metadata and cross-selling information.

## SYNTAX

```
Get-XmlEulandaShop [[-barcode] <String>] [[-articleNo] <String>] [[-articleId] <Int32>] [[-articleUid] <Guid>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-XmlEulandaShop` function generates an XML fragment for a given article. The article can be specified using parameters `Barcode`, `ArticleId`, `ArticleUid`, or `ArticleNo`. Access to the database can be done using an ADOCom object, a ConnectionString, or a UDL file.

This function requires the EULANDA shop interface to be installed. This extends the system with the `esolShopArtikel` file, which contains specific things such as metadata, article variants, unit prices, upselling, or cross-selling. The XML fragment is usually generated after the XML of the article but can be generated separately through this function.

## EXAMPLES

### Example 1:Generates an XML fragment  with shop specific data
```powershell
PS C:\> Get-XmlEulandaShop -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
```

```xml
<SHOP>
    <ARTICLETYPE>3</ARTICLETYPE>
    <MASTERARTICLE>350102-MASTER</MASTERARTICLE>
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
```

This example generates an XML fragment for the article with the article number '130100' using the UDL file 'C:\temp\Eulanda_1 Truccamo.udl' to access the EULANDA database.

## PARAMETERS

### -articleId
The `ArticleId` is a unique key in the table. It is normally only used internally to link tables together.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: id

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -articleNo
The `ArticleNo` is a unique alphanumeric field in the ERP system. If the value is set, then the article is searched for here and its `Id` is returned.

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

### -articleUid
A UID (Unique Identifier) is a unique identifier assigned to a specific record in a database. In the context of EULANDA ERP software, each article is assigned a UID to uniquely identify it, regardless of its name, number, or other properties. The UID is usually automatically generated by the database and has a fixed length and formatting to ensure its uniqueness. The `articleUid` parameter is used to specify the UID of the article to retrieve the record.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases: uid

Required: False
Position: 3
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
Position: 0
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

### System.String
## NOTES

## RELATED LINKS


