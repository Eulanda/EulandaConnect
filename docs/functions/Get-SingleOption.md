---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-SingleOption.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-SingleOption

## SYNOPSIS
Returns an option in the correct notation

## SYNTAX

```
Get-SingleOption [[-value] <String>] [[-list] <String[]>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns an option in the correct notation. The string array list contains the valid option values. The first entry is special in that it is always used when an option is not recognized. This default value is returned in such a case.

## EXAMPLES

### Example 1:Returns a option from valid options
```powershell
PS C:\> Get-MultipleOption -values 'Navi' -list @('BLACK','WHITE','BLUE','RED','YELLOW')
```

```ini
# Output

BLACK
```

Because the **Navi** entry does not appear in the list of correct options, the default value `BLACK` is returned.

## PARAMETERS

### -list
An array of strings containing the valid options in the desired notation. The first element of the list is the default value which is returned if an entry in the list was not found.

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

### -value
Value is the option to be set. If it is found in the list of valid options, it will be returned as specified in the list. Differences in case will not cause an error. Only entries not found will then return the first entry, which is the default entry.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


