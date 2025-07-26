---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Read-VersionFromSynopsis.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Read-VersionFromSynopsis

## SYNOPSIS

Get the version number from the synopsis of a ps1 file

## SYNTAX

```
Read-VersionFromSynopsis [[-path] <String>] [[-maxLines] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

The synopsis normally does not contain a version number. However, it has become common practice to store this in the .NOTES area. If a valid version number is found there, it will be returned. The version number must be stored there in the form: `Version 1.5.2` etc. The PowerShell file is specified in the path parameter. The maximum number of lines to search the synopsis at the beginning of the file can be specified in `maxLines`. The default value is **250** lines.

## EXAMPLES

### Example 1:Read the Version number

```powershell
PS C:\> [version]$v = Read-VersionFromSynopsis -path "$PsScriptRoot\MyProject.ps1"
```

```ini
# Output

1.5.2
```

The PowerShell file `MyProject.ps1` is read and searched for the version entry.

## PARAMETERS

### -maxLines

The max. quantity of lines which are read. If the version is not found, the function returns 0.0.-1.-1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path

Path to the PowerShell ps1 file.

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


