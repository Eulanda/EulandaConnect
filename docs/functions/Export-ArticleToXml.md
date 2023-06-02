---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Export-ArticleToXml.md
schema: 2.0.0
---

# Export-ArticleToXml

## SYNOPSIS
xports an XML message type for Eulanda articles, calling various fragment functions to create the output. Compatible with the classic Eulanda shop interface format.

## SYNTAX

```
Export-ArticleToXml [[-select] <String>] [[-filter] <String[]>] [[-alias] <String>] [[-order] <String>]
 [-reorder] [-revers] [[-customerGroups] <String>] [[-breadcrumbPath] <String>] [-noEmptyPropertyTree]
 [[-path] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function exports an XML article message type by calling various fragment functions that are also available as commands. The format is compatible with the previously used shop interface. The description of the XML format is available in a separate GitHub project http://www.github.com/eulanda/EulandaXML for reference. A summary of the XML structure can be found in this documentation under [XmlStructure](../appendix/XmlStructure.md).

## EXAMPLES

### Example 1:Exports articles using the Eulanda standard XML structure
```powershell
PS C:\> Export-ArticleToXml -filter "ArtNummer>='1000' and ArtNummer<='1100'" -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -path "$(Get-DesktopDir)\ARTICLE.xml"
```

```xml
EULANDA>
    <METADATA>
        <VERSION>2.3.15</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2023-03-22T13:08:27</DATE>
        <PCNAME>DOE-PC</PCNAME>
        <USERNAME>JOHN</USERNAME>
    </METADATA>
    <MERKMALBAUM>
        <ARTIKEL>
            <MERKMAL>
                <ID>2277</ID>
                <PARENTID>38</PARENTID>
                <NAME>SHOP</NAME>
                <UID>{8E549CA7-CE73-418E-B2AD-743BA1AE7264}</UID>
                <SORT>0</SORT>
                <COLOR />
                <MERKMAL>
                    <ID>2280</ID>
                    <PARENTID>2277</PARENTID>
                    <NAME>Enterprise Linie</NAME>
                    <UID>{C412C2E2-290F-4ECE-AA68-A06F42866C69}</UID>
                    <SORT>0</SORT>
                    <COLOR>536870911</COLOR>
                    <MERKMAL>
                        <ID>2297</ID>
                        <PARENTID>2280</PARENTID>
                        <NAME>Ausstattungspakete</NAME>
                        <UID>{49561AFA-404B-4F1E-AC40-8F93BCC949E7}</UID>
                        <SORT>1</SORT>
                        <COLOR>536870911</COLOR>
                    </MERKMAL>
                    ...
```

This example demonstrates how to export articles using the Eulanda standard XML structure. The function is called with the -filter parameter to specify a range of article numbers to export. The -customerGroups parameter is used to specify which customer groups to use for pricing. The -udl parameter specifies the location of the UDL file for connecting to the Eulanda database. The resulting XML file is saved to the desktop. The output XML file contains metadata and a property tree with the article data.

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

### -breadcrumbPath
Specifies the root of a property tree path starting with a forward slash `/`. This parameter is used to search for the corresponding branch in the property tree and retrieve its ID. The retrieved ID is used to check if the current article is included in one or more breadcrumbs or catalogs. For each article, the resulting breadcrumbs or catalogs are outputted in their own node.

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

### -noEmptyPropertyTree
If this switch is set, the property is only displayed if child elements are found in the database. Otherwise, an empty XML tag with a subfield is output.

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

### -path
The parameter `-path` specifies the path and filename of the XML file to be exported. The default value is the current directory. If a file with the same name already exists, it will be overwritten. The file path must be valid and accessible for writing.

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
