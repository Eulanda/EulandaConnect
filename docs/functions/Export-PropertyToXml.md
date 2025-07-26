---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Export-PropertyToXml.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Export-PropertyToXml

## SYNOPSIS
This PowerShell function exports the entire property tree starting from a specified path in a hierarchical xml structure. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Export-PropertyToXml.ps1).

## SYNTAX

```
Export-PropertyToXml [-breadcrumbRoot <String>] [-noEmptyPropertyTree] [[-tablename] <String>]
 [[-path] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Exports the complete property tree starting from a certain path in a hierarchical structure. The `-npEmptyPropertyTree` parameter can be used to specify that the node should be completely omitted if no data is found to be exported due to the specified parameters. If a path is specified, the XML file is saved there, otherwise the XML structure is returned as an XML string.

Access to the database is done either via an ADO COM object, a connection string, or a UDL file.

## EXAMPLES

### Example 1:Exports the property tree of articles as xml
```powershell
PS C:\> Export-PropertyToXml -breadcrumbPath '\shop' -tablename 'Article' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

```xml
<EULANDA>
    <METADATA>
        <VERSION>2.3.15</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2023-03-22T16:41:43</DATE>
        <PCNAME>DOE-PC</PCNAME>
        <USERNAME>JOHN</USERNAME>
    </METADATA>
    <MERKMALBAUM>
        <ARTIKEL>
            <MERKMAL>
                <ID>133</ID>
                <PARENTID>47</PARENTID>
                <NAME>SHOP</NAME>
                <UID>{1D3C5272-BB5F-4B63-88E4-B48F11FE7695}</UID>
                <SORT>0</SORT>
                <COLOR />
                <MERKMAL>
                    <ID>166</ID>
                    <PARENTID>133</PARENTID>
                    <NAME>Ausstattung</NAME>
                    <UID>{0628D2F7-BBC0-4A55-B340-1CEA90945D10}</UID>
                    <SORT>0</SORT>
                    <COLOR>536870911</COLOR>
                    <MERKMAL>
                        <ID>171</ID>
                        <PARENTID>166</PARENTID>
                        <NAME>Pinsel</NAME>
                        <UID>{033C07ED-63DA-4331-B3CD-DCB5A05597B2}</UID>
                        <SORT>0</SORT>
                        <COLOR>536870911</COLOR>
                        ...
```

Exports the property tree of articles under the specified breadcrumb path in XML format using the UDL file specified.

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

### -path
The parameter `-path` specifies the path and filename of the XML file to be exported. The default value is the current directory. If a file with the same name already exists, it will be overwritten. The file path must be valid and accessible for writing.

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

### -tablename
The parameter specifies the name of the table for which the property tree should be exported. Currently, three tables are supported: Article, Address, and Delivery. The valid table names can be retrieved using the `Get-MappingTablename` function, which allows input in both the native and English names.

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

### -breadcrumbRoot
Specifies the root of a property tree path. This parameter is used to search for the corresponding branch in the property tree and retrieve its ID. The retrieved ID is used for the tree starting from this point.

```yaml
Type: String
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


