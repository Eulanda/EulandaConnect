---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ResStr.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-ResStr

## SYNOPSIS
Returns the string resource in the user's language

## SYNTAX

```
Get-ResStr [[-Key] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Parallel to the EulandaConnect module, language resources can be stored with the file extension '.resx'. The file name is additionally extended by the language in the .NET notation. For EulandaConnect in German the language file is named EulandaConnect.de-DE.resx. For the US-American language resource it is named EulandaConnect.en-US.resx. 
Within EulandaConnect language resources are stored with a key so that a call with the desired parameter Key, accordingly displays the resource in the own language.
The format resx is a standard format from Microsoft, so any language can be added to a running system. If a matching language file is not found, the US language file is used.

## EXAMPLES

### Example 1:Returns the text of the resource for a key
```powershell
PS C:\> Get-RestStr -key 'OUT_WELCOME_EXECUTIONSTART'
```

```ini
# Output

Execution start: {0}
```

The output depends on the user's language, and of course whether the language file is available in that language.

## PARAMETERS

### -Key
Key to the desired language resource.

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


