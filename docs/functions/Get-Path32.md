---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Path32.md
schema: 2.0.0
---

# Get-Path32

## SYNOPSIS
Returns the Windows path for 32-bit programs

## SYNTAX

```
Get-Path32 [<CommonParameters>]
```

## DESCRIPTION
The function returns the Windows path for 32-bit programs. This differs depending on whether it is a 32-bit or a 64-bit Windows.

## EXAMPLES

### Example 1:Returns the program path for 32-bit apps
```powershell
PS C:\> Get-Path32
```

```ini
# Output

C:\Program Files (x86)
```

In this example, the command was run from a 64-bit Windows system.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
