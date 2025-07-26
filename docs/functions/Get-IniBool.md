---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-IniBool.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-IniBool

## SYNOPSIS
Returns a Boolean variable from an ini file

## SYNTAX

```
Get-IniBool [[-section] <String>] [[-variable] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns the boolean value from an `INI` file where the variable was specified by `section` and `variable`. The name of the `INI` file is fixed with `$global:ini`. If the variable does not exist, `$false` is returned.

## EXAMPLES

### Example 1:Returns a boolean from a ini file
```powershell
PS C:\> Get-BoolIni -section 'SESSION' -variable 'utf'
```

Returns the value specified for 'utf' in the 'SESSION' section of the ini file.

## PARAMETERS

### -section
Specifies the name of the section in the INI file.

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

### -variable
Specifies the name of the variable within a section of the ini file.

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

[Read-IniFile](../functions/Read-IniFile.md)

[Get-Bool](../functions/Get-Bool.md)






