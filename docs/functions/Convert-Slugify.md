---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-Slugify.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Convert-Slugify

## SYNOPSIS
This PowerShell function converts a string so that only letters from a-z, underscores and digits are output. All other letters are converted to these base letters if possible. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-Slugify.ps1).

## SYNTAX

```
Convert-Slugify [[-value] <String>] [[-strCase] <String>] [[-delimiter] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Converts the text from value to a contiguous string consisting only of letters a-z, digits 0-9 and an underscore.
Special characters from the different languages are automatically converted in a meaningful way, e.g. **ö** becomes **oe**.
All other characters are converted to an underscore. If several underscores meet, all but one are removed. 
The output can be additionally controlled by the parameter `strCase`. Here the output can be converted completely into **lowercase** or **uppercase** letters or into **capizalized**. 

## EXAMPLES

### Example 1:Converts the text from value to a contiguous string of a-z 0-9 and underscore
```powershell
PS C:\> [string]$myOutput= convert-slugify -value 'Mein Haus Österreich'
PS C:\> Write-Host $myOutput
```

```powershell
# Output

mein_haus_oesterreich
```

The function converts the text into a slugy text. All special characters are removed and words are connected with underscores.

## PARAMETERS

### -delimiter
The delimiter connects the words to each other. The default delimiter is the underscore character. Alternatively, the hyphen can be specified as the delimiter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: -, _

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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


