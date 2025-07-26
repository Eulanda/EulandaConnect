---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-Snapshot.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-Snapshot

## SYNOPSIS
This PowerShell function named `New-Snapshot` creates a Volume Shadow Copy (snapshot) on a specified drive and makes it accessible through a symbolic link. It is suitable for making backups of open files or compressing directories without errors.

## SYNTAX

```
New-Snapshot [[-volume] <String>] [[-symbolicLink] <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `New-Snapshot` function provides a way to create a snapshot of a given volume or drive in the Windows operating system. A snapshot, or shadow copy, is a copy of a volume or a set of files at a particular point in time. It can be very useful for backing up data, especially open files, or compressing directories without errors, because it provides a frozen image of the files, thereby preventing issues with files being modified during the backup or compression process.

The function creates a volume shadow copy of the specified volume and returns a data structure containing essential details, such as the shadowID, volume, snapshot path, and symbolic link name. This data structure can be used later as input for the `Remove-Snapshot` function to delete the corresponding snapshot.

> **ATTENTION**: The function requires administrative rights! If the function is run without these privileges, an exception is thrown.

## EXAMPLES

### Example 1: Creating a snapshot on the D: drive and accessing it through a symbolic link named D:\mySnapshot
```powershell
PS C:\> $snaphot = New-Snapshot -volume "D:" -symbolicLink "D:\mySnapshot"
PS C:\> # Your commands like compress that folder
PS C:\> # Get-ChildItem -Path "D:\mySnapshot"
PS C:\> Remove-Snapshot -snapshot $snapshot
```

In this example, the `New-Snapshot` function is used to create a snapshot of the D: drive. The snapshot is accessible through a symbolic link located at `D:\mySnapshot`. You can perform operations such as compressing or copying data within this snapshot directory. After you're done, the `Remove-Snapshot` function is used to delete the snapshot along with the symbolic link.

Please note that you can add your own specific commands or operations between the creation of the snapshot and the removal of the snapshot. Adjust the paths and parameters as needed for your use case.

## PARAMETERS

### -symbolicLink
Path to the symbolic link that should provide access to the snapshot. Default: `$volume\ecSnapshot`.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -volume
The drive where the snapshot is to be created. The parameter must be specified in the format 'Letter:', e.g., 'C:'. If not provided, the system drive is used. Default: `$ENV:SystemDrive`.

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

[Remove-Snapshot](./functions/Remove-Snapshot.md)




