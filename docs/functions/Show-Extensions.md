---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Show-Extensiom.md
schema: 2.0.0
---

# Show-Extensions

## SYNOPSIS
Shows the file extensions like txt, exe etc. of known extension in the file explorer

## SYNTAX

```
Show-Extensions [<CommonParameters>]
```

## DESCRIPTION
Windows File Explorer hides the file extensions for known files. If you want to show them, this function can change them for you.

## EXAMPLES

### Example 1:Shows the file extensions in the file explorer
```powershell
PS C:\> Show-Extensions
```

Enables the display of file extensions for known files.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Hide-Extensions](./functions/Hide-Extensions.md)

[Update-Desktop](./functions/Update-Desktop.md)
