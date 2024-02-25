---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaProperty.md
schema: 2.0.0
---

# Get-XmlEulandaProperty

## SYNOPSIS
Exports the property tree starting from a certain path as a xml fragment.

## SYNTAX

```
Get-XmlEulandaProperty [-breadcrumbRoot <String>] [[-tablename] <String>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Exports the property tree starting from a certain path as a xml fragment in a hierarchical structure. The XML structure is returned as an XML string and has no metadata and also no Eulanda root.

## EXAMPLES

### Example 1:Exporting Property Tree as Fragmental XML with PowerShell
```powershell
PS C:\> Get-XmlEulandaProperty -breadcrumbPath '\Produkte' -tablename 'Address' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

```xml
<MERKMALBAUM>
    <ADRESSE>
        <MERKMAL>
            <ID>35</ID>
            <PARENTID>33</PARENTID>
            <NAME>Produkte</NAME>
            <UID>{4CEA6D28-A1C4-4978-B94C-0E4DA370CA94}</UID>
            <SORT>0</SORT>
            <COLOR />
            <MERKMAL>
                <ID>1740</ID>
                <PARENTID>35</PARENTID>
                <NAME>EULANDA Produktversion</NAME>
                <UID>{9A34271F-0F1F-4CE4-AC0B-084CB5B75ED5}</UID>
                <SORT>0</SORT>
                <COLOR />
                <MERKMAL>
                    <ID>1746</ID>
                    <PARENTID>1740</PARENTID>
                    <NAME>Eulanda 0.0 - ohne Version</NAME>
                    <UID>{194CEE59-176A-42E4-84C8-EF8A5C29F2BB}</UID>
                    <SORT>1</SORT>
                    <COLOR />
                </MERKMAL>
                ...
```

This example demonstrates how to export the property tree of an article in a fragmental XML format. The `-breadcrumbPath` parameter specifies the path of the property tree to be exported, starting with the root `\`. The `-tablename` parameter specifies the name of the table to which the property tree belongs. The `-udl` parameter specifies the path to the UDL file for the database connection.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 4
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
Position: 3
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

