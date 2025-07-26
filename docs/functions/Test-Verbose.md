---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-Verbose.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-Verbose

## SYNOPSIS
Tests if the verbose switch is set

## SYNTAX

```
Test-Verbose [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Tests if the verbose switch is set.

## EXAMPLES

### Example 1:Tests if verbose mode is active
```powershell
PS C:\> if (Test-Verbose) { Write-Host 'We are in verbose mode' }
```

When the verbose switch is active, the following message is displayed: `We are in verbose mode`.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


