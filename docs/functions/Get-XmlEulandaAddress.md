---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaAddress.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-XmlEulandaAddress

## SYNOPSIS
Creates an XML fragment containing address information based on the specified selection criteria.

## SYNTAX

```
Get-XmlEulandaAddress [[-select] <String>] [[-filter] <String[]>] [[-alias] <String>] [[-order] <String>]
 [-reorder] [-revers] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates an XML fragment with the addresses selected from the database based on the specified selection criteria. The `select` parameter is used to specify the list of columns to be retrieved, while the `filter` parameter is used to specify the filter criteria. The `order` parameter is used to specify the order in which the results are sorted. The `alias` parameter is used to specify an alias for the key field, which is normally the field `match`. The `reorder` and `revers` parameters are used to specify whether the fieldnames should be reordered (alphabetically) or reversed if the records should be in reverse order.

## EXAMPLES

### Example 1:Retrieves an XML fragment for address fields
```powershell
PS C:\> Get-XmlEulandaAddress -select 'Name1,Name2,Name3,Strasse,Ort' -filter "Match = 'EULANDA'" -udl "C:\temp\Eulanda_1 Eulanda.udl"
```

```xml
<ADRESSELISTE>
    <ADRESSE>
        <ID.ALIAS>EULANDA</ID.ALIAS>
        <MATCH>EULANDA</MATCH>
        <NAME1>EULANDA Software GmbH</NAME1>
        <NAME2>c/o John Doe</NAME2>
        <NAME3>3rd floor</NAME3>
        <STRASSE>Beuerbacher Weg 20</STRASSE>
        <ORT>Hünstetten</ORT>
    </ADRESSE>
</ADRESSELISTE>
```

This example generates an XML fragment containing address information for addresses that match the filter criteria "Match = 'EULANDA'". The resulting XML fragment contains only the columns specified in the `select` parameter.

## PARAMETERS

### -alias
The alias is historically the field 'Match' of the address table. In an XML output the node is always 'ID.ALIAS'. This alias is used to uniquely associate the record and can now refer to another unique field. Currently these are UID, ID,  and MATCH.

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

### -filter
The filter is an array of strings and the filtering refers to the master dataset. Each row of the array is added individually to the existing filters via logical AND. By default, records whose match starts with '.MUSTER' are hidden. For example, a filter could be "MATCH <> 'BOND'".

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
The field by which the output is to be sorted. If nested sorting is required, multiple field names can be specified comma-separated.

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
The list of field names can be sorted in the output.

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
The output of the record sorting can be done backwards.

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
By default, all fields intended for output are retrieved. However, select can be used to specify a comma-separated list of the desired field names.

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


