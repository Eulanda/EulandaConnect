---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-StringCase.md
schema: 2.0.0
---

# Convert-StringCase

## SYNOPSIS
Converts text to lowercase, uppercase, or capitalized

## SYNTAX

```
Convert-StringCase [[-value] <String>] [[-strCase] <String>] [<CommonParameters>]
```

## DESCRIPTION
Converts text to lowercase, uppercase, or capitalized. With Capitalized, only the first letter starts in upper case.

## EXAMPLES

### Example 1:Converts text in upper case
```powershell
PS C:\> [string]$myOutput= Convert-StringCase -value 'Hello, i am John, John Doe' -strCase upper
PS C:\> Write-Host $myOutput
```

```powershell
# Output

HELLO, I AM JOHN, JOHN DOE
```

The text specified in value is converted to uppercase. The strCase parameter also allows conversion to lowercase or capitalized.

## PARAMETERS

### -strCase
By setting the parameter `strCase` you can influence the output. If the parameter is omitted or set to `none`, no further conversion is performed. With `lower` the output is converted to lowercase, with `upper` to uppercase and with `capitalize` the first letter of a word is output in uppercase.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: none, upper, lower, capital

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
The text to be converted

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
