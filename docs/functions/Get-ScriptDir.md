---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ScriptDir.md
schema: 2.0.0
---

# Get-ScriptDir

## SYNOPSIS
Returns the path to the script that will be executed

## SYNTAX

```
Get-ScriptDir [<CommonParameters>]
```

## DESCRIPTION
If the path cannot be determined, an attempt is made to obtain the path via the `$PSScriptRoot` runtime variable. If this also fails, the current directory is returned.

## EXAMPLES

### Example 1:Returns the path of the script
```powershell
PS C:\> Get-ScriptDir
```

Returns the path of the calling script.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
