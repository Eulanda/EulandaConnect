---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Read-IniFile.md
schema: 2.0.0
---

# Read-IniFile

## SYNOPSIS
Reads a classic Windows ini file

## SYNTAX

```
Read-IniFile [[-path] <FileInfo>] [<CommonParameters>]
```

## DESCRIPTION
The function reads a classic Windows ini file with sections and values into a nested hash table. The values can then be accessed by specifying the section name and the field name. Comments in the ini file are skipped.

## EXAMPLES

### Example 1:Reads Win.ini file
```powershell
PS C:\> $ini= Read-IniFile -Path C:\Windows\win.ini
PS C:\> $ini
```

```ini
# Output

Name                           Value
----                           -----
fonts                          {}
mci extensions                 {}
Mail                           {[MAPI, 1]}
extensions                     {}
files                          {}
No-Section                     {}
```

```powershell
PS C:\> $ini['Mail']['Mapi']
```

```ini
# Output

1
```

Reads the Windows ini file into the $ini variable. Then you can access the `MAPI` label of the `Mail` section and read the value.

## PARAMETERS

### -path
Path to the ini file.

```yaml
Type: FileInfo
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

PowerShell unfortunately does not have a built-in function to process classic INI files. For new projects you will rather use YAML. But for older projects or backwards compatibility this is a viable alternative.

## RELATED LINKS

[Get-IniBool](Get-IniBool.md)
