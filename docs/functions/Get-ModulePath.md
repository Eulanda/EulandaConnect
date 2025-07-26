---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-ModulPath.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-ModulePath

## SYNOPSIS
Returns the pure path specification to a module name

## SYNTAX

```
Get-ModulePath [[-module] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the clean path where the module specified by the `Module` parameter is located.

## EXAMPLES

### Example 1:Returns the path to a module name
```powershell
PS C:\> Get-ModulePath -module EulandaConnect
```

```ini
# Output

C:\Users\John\Documents\PowerShell\Modules\EulandaConnect\2.1.11
```

For the module name `EulandaConnect` the path is returned where the module is stored.

## PARAMETERS

### -module
Name of the module to which the path is to be determined

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


