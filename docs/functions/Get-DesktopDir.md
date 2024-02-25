---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DesktopDir.md
schema: 2.0.0
---

# Get-DesktopDir

## SYNOPSIS
Returns the path to the desktop

## SYNTAX

```
Get-DesktopDir [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the path to the desktop of the logged in user. The path does not contain a terminating backslash.

## EXAMPLES

### Example 1:Returns the path to the desktop
```powershell
PS C:\> Get-DesktopDir
```

```ini
# Output

C:\Users\JohnDoe\Desktop
```

Returns the path to the desktop for the user John Dow.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-TempDir](../functions/Get-TempDir.md)





