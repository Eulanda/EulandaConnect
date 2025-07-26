---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-TranslateSection.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-TranslateSection

## SYNOPSIS
Returns a language section from a continuous text

## SYNTAX

```
Get-TranslateSection [[-text] <String>] [[-iso] <String>] [-sub <String>] [-subDefault <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function returns a language section from a continuous text. This way of storing languages in a text block is specific for the EULANDA ERP. The text for example of an article can contain several languages. For this the individual sections are provided with an `iso` language separator. This is put in an own line and in square brackets, e.g. `[EN]` for English.

If the desired language is not found, the text before the first language separator is returned.

The language separator can be extended additionally.  In this case, the sub-delimiter must be specified with a colon from the language delimiter. The text of the sub-separator is completely free and can specify a text. For example [EN: TECHNICS] or [EN: INTERNAL] etc.

If the `sub` divider is not found, a fixed default value can be specified in the `subDefault` parameter. 

## EXAMPLES

### Example 1:Text example with different languages and a standard text for unknown languages
```ini
# Input as $text

This is my default text, It is used when no language is found
[EN]
The moon always has the same face
[DE]
Der Mond hat immer das selbe Gesicht
[IT]
La luna ha sempre la stessa faccia
```

```powershell
PS C:\> Get-TranslateSection -text $text -iso 'IT'
```

```ini
# Output

La luna ha sempre la stessa faccia
```

This text block contains three languages and one text for unknown languages. If `iso` is specified as Italian, the result is: `La luna ha sempre la stessa faccia`. If the function `Get-TranslateSection` requests French with `FR` as `iso`, this would not be found and accordingly the default text `This is my default text, It is used when no language is found` is returned.

### Example 2:Text example with a subsection, as well as a standard text for unknown languages
```ini
# Input as $text

[EN]
The moon always has the same face
[EN:TECHNICS]
The moon has a diameter of about 3,474 kilometers
[DE]
Der Mond hat immer das selbe Gesicht
[DE:TECHNICS]
Der Mond hat einen Durchmesser von etwa 3.474 Kilometern
```

```powershell
PS C:\> $result= Get-MultipleOption -text $text -iso 'EN' -sub 'TECHNICS'
PS C:\> Write-Host $result
```

```ini
# Output

The moon has a diameter of about 3,474 kilometers
```

The section `TECHNICS`, is searched for and returned in the language section English. The name `TECHNICS` is only an example, any number of sections can be defined in this way. The function here returns `The moon has a diameter of about 3,474 kilometers`.

### Example 3:Like example 2, but there is a section for unknown languages
```ini
# Input

This is my default text, It is used when no language is found
[:TECHNICS]
No technical information available
[EN]
The moon always has the same face
[EN:TECHNICS]
The moon has a diameter of about 3,474 kilometers
```

```powershell
PS C:\> $result= Get-MultipleOption -text $text -iso 'FR' -sub 'TECHNICS'
PS C:\> Write-Host $result
```

```ini
# Output

No technical information available
```

Here, French is specified as the language, but it is not defined. In this case the neutral section is returned. There is a neutral section for `TECHNICS`, so the function returns: `No technical information available`.

## PARAMETERS

### -iso
A two-letter language identifier. `EN` for English, `IT` for Italian `DE` for German, etc.

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

### -sub
Defines a subsection for a language. These are freely selectable and are separated from the actual `iso` language identifier by a colon.

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

### -subDefault
If no subsection is found, a default can be provided for this case.

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

### -text
The text containing the different languages. For paragraphs are used in the continuous text with CRLF, as it is usual under Windows.

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


