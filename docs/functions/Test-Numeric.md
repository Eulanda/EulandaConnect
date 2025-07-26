---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-Numeric.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-Numeric

## SYNOPSIS
Tests if a string contains only numeric characters, with the option to allow zero.

## SYNTAX

```
Test-Numeric [[-value] <String>] [-allowZero] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Test-Numeric function tests if a given string contains only numeric characters (digits and optional decimal points). The function also provides an option to allow zero as a valid numeric value. The function returns a boolean value indicating whether the string is a valid numeric value or not.

## EXAMPLES

### Example 1: Tests if  `45x` is a numeric value
```powershell
PS C:\> Test-Numeric -value '45x'
```

Returns 'False' as the string '45x' contains a non-numeric character.

## PARAMETERS

### -allowZero
A switch parameter that indicates if zero is allowed as a valid numeric value. By default, zero is not allowed.

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

### -value
The string value to be tested for numeric characters.

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

### System.Boolean
## NOTES

## RELATED LINKS


