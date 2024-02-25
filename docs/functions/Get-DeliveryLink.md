---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DeliveryLink.md
schema: 2.0.0
---

# Get-DeliveryLink

## SYNOPSIS
Creates a condition for the where case of an SQL query to select a delivery note.

## SYNTAX

```
Get-DeliveryLink [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-alias] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function creates a condition for an SQL query to select a delivery note. This can be found both via the ID and via its delivery note number. In addition, by specifying an alias, a query can also be made for the details.

## EXAMPLES

### EXAMPLE 1:Provides the link to connect header and position data
```powershell
PS C:\> [string]$sqlFrag = Get-DeliveryLink -deliveryNo 430220
```

```sql
KopfNummer = 43020
```

Provides the link to connect the delivery bill items to the delivery bill header (= master/detail). This text is then used by `Get-DataFromSql` to create the nested hash tables.

## PARAMETERS

### -alias
The alias is used to execute the condition for the SQL query of the details, i.e. the associated positions. For the delivery note the alias is usually 'lf'.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects
## OUTPUTS

### string
## NOTES

## RELATED LINKS

