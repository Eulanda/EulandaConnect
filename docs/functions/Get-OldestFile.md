---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-OldestFile.md
schema: 2.0.0
---

# Get-OldestFile

## SYNOPSIS
Get oldest filename from a directory

## SYNTAX

```
Get-OldestFile [[-path] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function returns the oldest file of a folder. The parameter `filemask` is specified with path and file mask.

## EXAMPLES

### Example 1:Returns the oldest text file from a folder
```powershell
PS C:\> Get-OldestFile -filemask 'C:\temp\*.txt'
```

```ini
# Output

logo.txt
```

In this example the oldest text file from the folder `C:\temp` is returned.

## PARAMETERS

### -path
Specifies the path, including the file mask, for which the oldest file should be found.

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
