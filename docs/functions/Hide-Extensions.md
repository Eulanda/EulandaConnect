---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Hide-Extensions.md
schema: 2.0.0
---

# Hide-Extensions

## SYNOPSIS
Hides the 'Hide extension' option in Windows File Explorer

## SYNTAX

```
Hide-Extensions [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Windows file explorer hides the file extensions for known files. If this option is not set, it can be set again via Hide-Extensions.

## EXAMPLES

### Example 1:Hides the extension in Windows file explorer
```powershell
PS C:\> Hide-Extensions
```

This suppresses the display of file extensions for known files.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Show-Extensions](./functions/Show-Extensions.md)

[Update-Desktop](./functions/Update-Desktop.md)



