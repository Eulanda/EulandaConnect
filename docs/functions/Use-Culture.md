---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Use-Culture.md
schema: 2.0.0
---

# Use-Culture

## SYNOPSIS
Performs any function in the context of another culture

## SYNTAX

```
Use-Culture [[-culture] <CultureInfo>] [[-script] <ScriptBlock>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This function can be used to format dates or numbers in the context of a different culture. For example, the output of the date in French format.

## EXAMPLES

### Example 1:Date output in french
```powershell
PS C:\>  Use-Culture -culture 'fr-FR' -script { $(Get-Date) }
```

```ini
# Output

dimanche 26 février 2023 15:51:53
```

The date output is in a culture different from Windows. This makes it easy to provide data exports for another country or to read them.

## PARAMETERS

### -culture
Specification of the culture in .NET format. `de-DE` for German, `en-US` for English US-American etc.

```yaml
Type: CultureInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -script
The script must always be specified in curly brackets.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

