---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/ConvertTo-USFloat.md
schema: 2.0.0
---

# ConvertTo-USFloat

## SYNOPSIS
This PowerShell function converts a string representation of a float number into a U.S. format. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/ConvertTo-USFloat.ps1).

## SYNTAX

```
ConvertTo-USFloat [[-inputString] <String>] [<CommonParameters>]
```

## DESCRIPTION
The `ConvertTo-USFloat` function takes a string that represents a float number, which could be formatted in either U.S. (dot as decimal separator, comma as thousands separator) or European (comma as decimal separator, dot as thousands separator) style, and converts it into a U.S. style float string (dot as decimal separator, no thousands separator). 

## EXAMPLES

### Example 1: Converts German float string to US float string
```powershell
PS C:\> ConvertTo-USFloat -inputString "2.561,12"
Returns: "2561.12"
```

In this example, the string "2.561,12" is passed as input to the `ConvertTo-USFloat` function. This input string represents a float number in European style: 2.561 as thousands part and 12 as decimal part. The function will convert this European style float string into a U.S. style float string, which uses a dot as the decimal separator and has no thousands separator.

## PARAMETERS

### -inputString
A string that represents a float number. The string could be formatted in either U.S. or European style.

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

This function assumes that the last occurrence of dot or comma in the input string is the decimal separator. If there are non-numeric characters other than dot and comma, or if the input string is not a valid representation of a float number, the function will throw an error.

## RELATED LINKS
