---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/docs/Get-Spaces.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-Spaces

## SYNOPSIS
Returns a string from spaces

## SYNTAX

```
Get-Spaces [[-count] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns a string of spaces. The number of spaces is specified by the count parameter.

## EXAMPLES

### Example 1Returns spaces
```powershell
PS C:\> (Get-Spaces -count 10)+"This ends here"
```

```ini
# Output

          This ends here
```

Returns count spaces.

## PARAMETERS

### -count
Count of blanks to be output

```yaml
Type: Int32
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


