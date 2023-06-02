---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-Administrator.md
schema: 2.0.0
---

# Test-Administrator

## SYNOPSIS
Returns true if the user has administrative rights

## SYNTAX

```
Test-Administrator [<CommonParameters>]
```

## DESCRIPTION
The function can be used to test whether the logged-in user has administrative rights on the PC.

## EXAMPLES

### Example 1:Tests if the user  has administrative rights
```powershell
PS C:\> if (Test-Administrator) { Write-Host 'You have administrative rights' }
```

If the user has administrative rights on the PC, the following message is displayed on the screen: `You have administrative rights`.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
