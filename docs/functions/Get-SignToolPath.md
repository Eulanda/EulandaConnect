---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-SignToolPath.md
schema: 2.0.0
---

# Get-SignToolPath

## SYNOPSIS
Determines the path to Windows signtool.exe

## SYNTAX

```
Get-SignToolPath [<CommonParameters>]
```

## DESCRIPTION
The function returns the path to the signtool.exe under Windows 10 and Windows 11. The path also contains the signtool.exe itself. SignTool is part of the Windows SDK. If there are multiple Windows SDK installations, the newest SignTool will be determined.

## EXAMPLES

### Example 1:Gets the path to the current signtool.exe
```powershell
PS C:\> Get-SignToolPath
```

```ini
# Output 

C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe
```

The result contains the path incl. the program name. The path depends on the version of the Windows SDK.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Approve-Signature](Approve-Signature.md)

[Install-SignTool](Install-SignTool.md)

