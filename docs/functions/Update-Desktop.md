---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Update-Desktop.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Update-Desktop

## SYNOPSIS
Sends a refresh message to the windows desktop

## SYNTAX

```
Update-Desktop [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Update-Desktop function operates as if you were pressing the F5 key on your Windows desktop. It refreshes the icons and their labels on the desktop. This function is used implicitly by the Hide-Extensions and Show-Extensions functions.

## EXAMPLES

### Example 1:Refreshes the desktop
```powershell
PS C:\> Upate-Desktop
```

Refreshes the desktop.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Hide-Extensions](../functions/Hide-Extensions.md)

[Show-Extensions](../functions/Show-Extensions.md)




