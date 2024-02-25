---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-Snapshot.md
schema: 2.0.0
---

# Remove-Snapshot

## SYNOPSIS
The `Remove-Snapshot` function deletes a snapshot that was previously created with `New-Snapshot`.

## SYNTAX

```
Remove-Snapshot [[-snapshot] <Object>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Remove-Snapshot` function serves to delete a snapshot (or volume shadow copy) that was previously created on a specified drive and accessed via a symbolic link. This function essentially undoes the operations performed by the `New-Snapshot` function. The function ensures that it is being run with administrator privileges, as deleting a shadow copy requires such rights.

> **ATTENTION**: The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## EXAMPLES

### Example 1: Removes a snapshot created prior with New-Snapshot
```powershell
PS C:\> Remove-Snapshot -snapshot $snapshot
```

In this example, the `Remove-Snapshot` function is used to remove a snapshot previously created with `New-Snapshot`. 

## PARAMETERS

### -snapshot
The snapshot to be removed. This parameter accepts only the function return value from `New-Snapshot`. This parameter is mandatory.

```yaml
Type: Object
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

[New-Snapshot](../functions/New-Snapshot.md)

