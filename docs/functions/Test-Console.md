---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-Console.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Test-Console

## SYNOPSIS
Tests whether the current PowerShell session is running in a console or RDP session.

## SYNTAX

```
Test-Console [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Test-Console function tests whether the current PowerShell session is running in a console or RDP session by checking the Win32_LogonSession class for RDP sessions. If an RDP session is detected, the function returns False. Otherwise, it returns True.

## EXAMPLES

### Example 1: Tests  PowerShell runs in a physical console
```powershell
PS C:\> Test-Console
```

Test whether the current PowerShell session is running in a console or RDP session.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean
## NOTES

## RELATED LINKS


