---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-AddressSql.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-AddressSql

## SYNOPSIS
This PowerShell function generates a SQL statement for selecting addresses from the database based on the specified selection criteria. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-AddressSql.ps1).

## SYNTAX

```
Get-AddressSql [[-select] <String>] [-filter <String[]>] [-strCase <String>] [-alias <String>]
 [-order <String>] [-noIdAlias] [-limit <Int32>] [-reorder] [-revers] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `select` parameter is used to specify the list of columns to be retrieved, while the `filter` parameter is used to specify the filter criteria. The `order` parameter is used to specify the order in which the results are sorted. The `-strCase` parameter specifies the case of the field names in the select statement. The `alias` parameter is used to specify an alias for the key field, which is normally the field `match`. The `noIdAlias` parameter is used to specify whether the ID.ALIAS column should be included in the output list of fields. The `limit` parameter is used to specify the maximum number of rows to return, while the `reorder` and `revers` parameters are used to specify whether the field names should be reordered (alphabetically) or reversed if the records should be in reverse order.

## EXAMPLES

### Example 1:Generates an SQL statement for selecting addresses from the database
```powershell
PS C:\> Get-AddressSql -select 'Name1,Name2,Name3,Strasse,Ort' -filter "Match = 'EULANDA'"
```

```sql
SELECT Match [ID.ALIAS], Match,Name1,Name2,Name3,Strasse,Ort FROM (
        SELECT

        /* KEYS */
        Id, Match, [Uid],

        /* IDENTIFIER */
        IsNull(FremdRefNr, '') [FremdRefNr], IsNull(FremdNr, 0) [FremdNr],
        IsNull(Fibukonto,0) [Fibukonto], IsNull(ILN,0) [ILN],

        /* GROUPS */
        IsNull(AdresseGr,'') [AdresseGr],

        /* ADDRESS */
        IsNull(Name1, '') [Name1], IsNull(Name2, '') [Name2], IsNull(Name3, '') [Name3],
        IsNull(Strasse, '') [Strasse], IsNull(Plz, '') [Plz], IsNull(Ort, '') [Ort],
        RTrim(LTrim(IsNull(Land, ''))) [Land],

        /* COMMUNICATION */
        IsNull(EMail, '') [EMail], IsNull(Tel, '') [Tel], IsNull(Fax, '') [Fax], IsNull(Auto, '') [Auto],
        IsNull(Homepage, '') [Homepage],

        /* CURRENCY */
        IsNull(Rabatt, '') [Rabatt], IsNull(UstId, '') [UstId],  IsNull(SteuerNr, '') [SteuerNr],
        IsNull(BankIBAN, '') [BankIBAN],  IsNull(BankBIC, '') [BankBIC],

        /* DESCRIPTION */
        IsNull(Karteikarte,'') [Karteikarte],

        /* OTHER */
        IsNull(Warnung,'') [Warnung]

        FROM Adresse

        WHERE ( RTrim(LTrim(IsNull(Match,'')))  <> '') AND Match = 'EULANDA'
        ) Dummy

        ORDER BY dummy.Match
```

This command generates a SQL statement that selects the columns `Name1`, `Name2`, `Name3`, `Strasse`, and `Ort` from the `Adresse` table where the `Match` column equals `'EULANDA'`. The resulting SQL statement is then executed against the database, and the results are returned as a PowerShell object.

## PARAMETERS

### -alias
The alias is historically the field 'Match' of the address table. In an XML output the node is always 'ID.ALIAS'. This alias is used to uniquely associate the record and can now refer to another unique field. Currently these are UID, ID,  and MATCH.

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

### -filter
The filter is an array of strings and the filtering refers to the master dataset. Each row of the array is added individually to the existing filters via logical AND. By default, records whose match starts with '.MUSTER' are hidden. For example, a filter could be "MATCH <> 'BOND'".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
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


