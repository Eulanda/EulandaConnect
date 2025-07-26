---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-TempDir.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-TempDir

## SYNOPSIS
Creates a random folder in the temporary files directory 

## SYNTAX

```
New-TempDir [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a randomly named folder in the temporary files directory and returns its path.

## EXAMPLES

### Example 1:Creates a temp folder
```powershell
PS C:\> New-TempDir
```

```ini
# Output

C:\Users\John\AppData\Local\Temp\42e18af7-dae8-47ea-a09f-7382727f3611
```

Creates a randomly named folder in the temporary files directory and returns the path to this folder.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


