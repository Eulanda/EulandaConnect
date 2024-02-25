---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-Shortcut.md
schema: 2.0.0
---

# New-Shortcut

## SYNOPSIS
Creates a shortcut to the specified file

## SYNTAX

```
New-Shortcut [[-file] <String>] [[-link] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A shortcut is created for the file specified in the `File` parameter. The location of the link is specified via the `link` parameter. If the shortcut already exists, the function is ignored. The name of the link must have the extension `.lnk`. 

## EXAMPLES

### Example 1:Creates a shortcut to the Desktop
```powershell
PS C:\> New-Shortcut -file 'C:\Windows\System32\Notepad.exe' -link "$(Get-DesktopDir)\IamHere.lnk"
```

Sets a link to Windows Notepad and creates it on the desktop.

## PARAMETERS

### -file
File including the complete path.

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

### -link
Path with the name of the link and the `.lnk` file extension.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

