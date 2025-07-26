---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-MultipleOptions.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-MultipleOptions

## SYNOPSIS
Returns a normalized string of the options

## SYNTAX

```
Get-MultipleOptions [[-values] <String>] [[-list] <String[]>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The allowed values are specified in a string array. The first element of the array is the default value, which is returned if a searched value was not found. Via the parameter values, the desired options are specified comma-separated as string. The search is case-insensitive and the result is the notation of the valid options.
The function serves to check values e.g. from a configuration file and to return in the notation indicated in the parameter list. In case of wrong values the default value is returned.

## EXAMPLES

### Example 1:Returns the options in the desired notation
```powershell
PS C:\> Get-MultipleOption -values 'blue,Yellow' -list @('BLACK','WHITE','BLUE','RED','YELLOW')
```

```ini
# Output

BLUE,YELLOW
```

The option 'blue' is written in lower case, but in the result it is returned in upper case as specified in the list. The option 'Yellow' with capital 'Y' also returns the notation specified in list.

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

### -values
A string with comma-separated words is passed via values. These options are then compared with the array and returned normalized.

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


