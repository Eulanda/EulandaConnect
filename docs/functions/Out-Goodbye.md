---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Out-Goodbye.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Out-Goodbye

## SYNOPSIS
Shows time span of the running script

## SYNTAX

```
Out-Goodbye [-normally] [-abnormally] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Out-Welcome is called at the beginning of a script and Out-Goodbye at the end of the script. This displays at the end the time that the script took for the entire execution between the two commands. There are two switch values with which you can control whether at the end of the script should be output that the execution was successful or with errors.

## EXAMPLES

### Example 1:Output of the goodby message for successful execution
```powershell
PS C:\> Out-Goodbye -normally
```

```ini
# Output

Execution start: 02/26/2023 09:38:38
Execution end:   02/26/2023 09:38:57
Duration:        18,99 seconds
Job finished normally
```

The output is intended to be called at the end of a script. In this case, the error values can be used to decide whether this should be displayed or not.

## PARAMETERS

### -abnormally
The text `Job finished abnormally` is displayed in red at the end of the duration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -normally
The text `Job finished normally` is displayed in blue at the end of the duration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

[Out-Welcome](./functions/Out-Welcome.md)




