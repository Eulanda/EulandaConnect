---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-LogName.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-LogName

## SYNOPSIS
Returns the name of a log file

## SYNTAX

```
Get-LogName [[-ident] <String>] [[-dateMask] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the name of a log file. The file name has the structure LOG-(Ident)-(DateMask).txt. Ident is a string, if it is not specified it is set to `DEF`. The same is true for the `dateMask`. If `dateMask` is not specified, the default is `yyyy-MM-dd--HH-mm-ss-fff`. For formatting the format switch included in PowerShell is used.

## EXAMPLES

### Example 1:Returns a file name for a log file
```powershell
PS C:\> Get-LogName
```

```ini
# Output

LOG-DEF-2023-02-24--14-57-25-855.txt
```

Returns the name for a log file. If no parameters are specified, the respective default values are used.

## PARAMETERS

### -dateMask
The date mask, for the formation of the file name. The default value is: `yyy-MM-dd--HH-mm-ss-fff`.

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

### -ident
The identification of the log file name is specified via the `ident` value. The default value is `DEF`.

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


