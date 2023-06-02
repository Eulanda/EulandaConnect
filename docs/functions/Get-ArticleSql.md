---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ArticleSql.md
schema: 2.0.0
---

# Get-ArticleSql

## SYNOPSIS
Creates a SQL command to retrieve a articles

## SYNTAX

```
Get-ArticleSql [[-select] <String>] [[-filter] <String[]>] [[-strCase] <String>] [[-alias] <String>]
 [[-order] <String>] [-noIdAlias] [-limit <Int32>] [-reorder] [-revers] [<CommonParameters>]
```

## DESCRIPTION
Generates an SQL command which by default retrieves all fields of the table and uses the article number as `ID.ALIAS`. The result of the function is always an array, even if only a single SQL command is returned as result here. This makes all functions of this type compatible with other functions like `Get-DataFromSql`. 

If not all fields are to be selected, the desired fields can be specified comma-separated via the `select` parameter. 

With the parameter `filter` simple restrictions can be defined in an array. For example that only a certain range of article numbers should be selected.

Sorting is done by default according to the alias field, which is the article number if nothing is specified. But with the parameter 'order' other fields can be used. Also fields which are not contained in the select list. Again, multiple nested sorting can be done by specifying a comma separated field list.

The parameter strCase allows to output field names in uppercase letters, for example. Further details can be found in the parameters section.

The historical XML format uses ID.ALIAS as a special alias to find an article by a unique key. The alias can also be set to other unique fields. A list of these can be found in the parameters. The field [`ID.Alias`] is set to the beginning of the output by default. But it can be suppressed by the switch `noIdAlias`. 

If you want only a small part of the result set, you can limit it with the `limit` parameter. If the value is set to `0`, there will be no data results, but you can retrieve the field list.

By `reorder` the field list is output alphabetically sorted and by the switch `revers` the sorting of the records can be reversed.

## EXAMPLES

### Example 1
```powershell
PS C:\> $sql = Get-ArticleSql -filter @('Barcode >= 1000000','Barcode <2000000') -alias Barcode
```

Creates an SQL command that retrieves all item fields. The amount of data is limited by the Barcode field. Only data with a barcode number between 1000000 and 1999999 will be output. The results are sorted by the barcode and the alias is not the default but the Barcode field.

## PARAMETERS

### -alias
The alias is historically the field 'ArticleNo' (= phys. ARTNUMBER) of the article table.
In an XML output the node is always 'ID.ALIAS'. This alias is used to uniquely associate the record and can now refer to another unique field. Currently these are UID, ID, ARTNUMBER and BARCODE. If BARCODE is used, it must be ensured that the field is unique in the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Id, Uid, ArtNummer, Barcode

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
The filter is an array of strings and the filtering refers to the master dataset. Each row of the array is added individually to the existing filters via logical AND. By default, items whose item number starts with '.MUSTER' are hidden. For example, a filter could be "BARCODE <>  '4711'".

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

### -limit
Limits the number of records output.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -noIdAlias
The special field 'ID.ALIAS' is not output, normally it is the first field of the output.

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
The field by which the output is to be sorted. If nested sorting is required, multiple field names can be specified comma-separated.

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

### -strCase
By setting the parameter `strCase` you can influence the output. If the parameter is omitted or set to `none`, no further conversion is performed. With `lower` the output is converted to lowercase, with `upper` to uppercase and with `capitalize` the first letter of a word is output in uppercase.

This specification refers to the field names.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: none, upper, lower, capital

Required: False
Position: 3
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
