---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-SymbolicLink.md
schema: 2.0.0
---

# New-SymbolicLink

## SYNOPSIS
Creates a new symbolic link to a target directory or file.

## SYNTAX

```
New-SymbolicLink [[-symbolicLink] <String>] [[-target] <String>] [[-flag] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The `New-SymbolicLink` function creates a new symbolic link at the specified path. The target can be a directory or a file, depending on the value of the `flag` parameter. It creates a new symbolic link at the specified path using the Windows API, not the `mklink` utility.

Symbolic links are capable of referencing the **GlobalRoot namespace**, which means that they can also be used to create links to **Volume Shadow Copy Service** (VSS) snapshots. This capability makes them suitable for accessing snapshots directly, making this function a valuable component used internally by the `New-Snapshot` cmdlet.

> **ATTENTION**: The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## EXAMPLES

### Example 1: Creates a symbolic link
```powershell
PS C:\> New-SymbolicLink -symbolicLink 'C:\MySymbolicLink' -target 'C:\temp'
```

Creates a symbolic link at 'C:\MySymbolicLink' that points to the directory 'C:\temp'.

## PARAMETERS

### -flag
An optional parameter that specifies whether the target is a directory or a file. The default value is 1, which means the target is a directory. If the target is a file, this parameter should be set to 0.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -symbolicLink
The path where the new symbolic link will be created. This acts as a kind of virtual path. Symbolic links are special files that serve as references or pointers to another files or directories in the file system. They can act as shortcuts, allowing for quick access to the target file or directory without requiring the full path.

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

### -target
The physical path of the target directory or file to which the symbolic link will point. This should be an existing path in your filesystem. When the symbolic link is accessed, the operating system treats it as if it were accessing the target path.

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

The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## RELATED LINKS

[Remove-SymbolicLink](./functions/Remove-SymbolicLink.md)
