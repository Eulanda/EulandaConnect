---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-SymbolicLink.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Remove-SymbolicLink

## SYNOPSIS
Removes an existing symbolic link.

## SYNTAX

```
Remove-SymbolicLink [[-symbolicLink] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Remove-SymbolicLink` function removes a symbolic link at the specified path, if it exists. The function verifies that the provided path indeed points to a symbolic link before trying to remove it. If the path points to a normal file or directory or if the symbolic link does not exist, the function will not perform the deletion and instead will inform the user about the situation. Like its counterpart, the `New-SymbolicLink` function, this function also requires **administrative** privileges. If the function is run without these privileges, an exception is thrown. 

> **ATTENTION**: The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## EXAMPLES

### Example 1: Removes a symbolic link
```powershell
PS C:\> Remove-SymbolicLink -symbolicLink 'C:\MySymbolicLink'
```

Removes the symbolic link at 'C:\MySymbolicLink', if it exists and is indeed a symbolic link.

## PARAMETERS

### -symbolicLink
The path to the symbolic link that is to be removed. This should be a previously created symbolic link.

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

The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## RELATED LINKS

[New-SymbolicLink](./functions/New-SymbolicLink.md)




