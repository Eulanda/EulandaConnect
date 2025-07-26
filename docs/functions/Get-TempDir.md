---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-TempDir.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-TempDir

## SYNOPSIS
Returns the path for temporary files

## SYNTAX

```
Get-TempDir [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the path for temporary files of the logged in user.

## EXAMPLES

### Example 1:Folder for temp files
```powershell
PS C:\> Get-TempDir
```

```ini
# Output

C:\Users\John\AppData\Local\Temp
```

Returns the path for temporary files.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-DesktopDir](../functions/Get-DesktopDir.md)






