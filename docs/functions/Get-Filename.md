---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Filename.md
schema: 2.0.0
---

# Get-Filename

## SYNOPSIS
Returns the file name incl. extension

## SYNTAX

```
Get-Filename [[-path] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the file name incl. extension from a fully qualified path.

## EXAMPLES

### Example 1:Returns filename of an udl file
```powershell
PS C:\>  Get-Filename -path "C:\temp\Eulanda_1 JohnDoe.udl"
```

```ini
# Outputh

Eulanda_1 JohnDoe.udl
```

Returns the file name incl. extension from a fully qualified path. In this example the function result is `Eulanda_1 JohnDoe.udl` if the parameter `path` is passed to the function as `C:\temp\Eulanda_1 JohnDoe.udl`.

## PARAMETERS

### -path
The parameter specifies the full path name, including file name and extension.

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

