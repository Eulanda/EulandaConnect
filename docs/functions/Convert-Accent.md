---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-Accent.md
schema: 2.0.0
---

# Convert-Accent

## SYNOPSIS
This PowerShell function converts special characters from other languages to the characters a-z. **ö** becomes **oe** etc. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-Accent.ps1).

## SYNTAX

```
Convert-Accent [[-value] <String>] [[-strCase] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function converts special characters that occur in a string into common characters from the US character set. **ö** becomes **oe**, **é** becomes an **e**.
Additionally it is possible to output the characters of the output in lowercase, uppercase or capitalized. If nothing is specified for the `strCase` parameter, no further conversion is performed.

## EXAMPLES

### Example 1:Converts special characters to US characters a-z
```powershell
PS C:\> [string]$myOutput= Convert-Accent -value "Häuser stehen in Zürich"
PS C:\> Write-Host $myOutput
```

```powershell
# Output

Haeuser stehen in Zuerich
```

In this example, a simple transformation of the text is performed. Characters like the German umlauts are converted here.

## PARAMETERS

### -strCase
By setting the parameter `strCase` you can influence the output. If the parameter is omitted or set to `none`, no further conversion is performed. With `lower` the output is converted to lowercase, with `upper` to uppercase and with `capitalize` the first letter of a word is output in uppercase.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
The text to be converted, which may contain the special characters or umlauts from foreign languages.

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

[Convert-Accent.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-Accent.ps1)





