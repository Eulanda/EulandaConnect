---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Approve-Signature.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Approve-Signature

## SYNOPSIS
This PowerShell function signs a script or program with an EV certificate. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Approve-Signature.ps1).

## SYNTAX

```
Approve-Signature [[-path] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Signs a script, module or exe program with an Authenticode certificate. 

The prerequisite is that the sign tool from the Microsoft SDK and compatible software such as the SafeNet Authentication Client from Thales are installed. The Signtool can be installed using the `Install-Signtool` function from this module. In addition, a valid token (USB device) for the EV certificate must be available. 

> The dongle must be plugged into the signing PC or connected via a probe server such as the UTN servers from SEH. This is tested and used with the dongle Token-JC, which also works in virtual environments with the UTN server.

If the path parameter is specified without path and without extension, the current path is assumed and ps1 is used as extension.  If the parameter is not specified or empty, then the name of the folder is used as file name and it is tested whether a ps1, psm1 or an exe with the name can be found. 

## EXAMPLES

### Example 1:Signs a PowerShell script
```powershell
PS C:\> Approve-Signature test
```

Signs the script `.\test.ps1` in the current folder.

## PARAMETERS

### -path
Path to the script or executable file to be signed. If no extension is specified or no path is specified, **ps1** is used as extension and the **current path** is used as path. If the parameter is not specified or empty, then the name of the folder (or the last folder name) is used as file name and it is tested whether a ps1, psm1 or an exe with the name can be found. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-SignToolPath](../functions/Get-SignToolPath.md)

[Install-SignTool](../functions/Install-SignTool.md)







