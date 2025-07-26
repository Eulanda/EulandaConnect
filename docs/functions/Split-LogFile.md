---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Split-LogFile.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Split-LogFile

## SYNOPSIS
This function is designed to split large log files into smaller, more manageable parts based on a specified file size limit.

## SYNTAX

```
Split-LogFile [[-inputPath] <String>] [[-outputFolder] <String>] [[-outputMask] <String>]
 [[-dateMask] <String>] [[-maxFileSize] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function is designed to read and process large log files by splitting them into smaller files. The splitting is guided by a defined maximum file size parameter. 

The Split-LogFile function is particularly ideal for use with FileZilla Server logs, though it can effectively handle a variety of other log file systems as well. 

The function provides the flexibility to reprocess a folder of previously split log files into a new one with a different maximum file size. This might be useful in situations where storage requirements or readability needs change over time. 

Another key feature of this function is its ability to handle any residual data from previous executions. If the function is run again after an earlier execution, it can recognize an incompletely filled file from the earlier run, and continue from where it left off.

The output file names include a timestamp and a file counter to ensure uniqueness, thus making it easy to track the chronological sequence of the split files.

## EXAMPLES

### Example 1: Split logfiles into smaller or bigger ones in a chronological order
```powershell
PS C:\> Split-LogFile -inputPath "C:\temp\filezilla-server.*.log" -outputFolder "C:\temp\Output" -maxFileSize 2MB
```

This example demonstrates the usage of the Split-LogFile function. Here, the function splits all files that match the pattern "filezilla-server.*.log" in the "C:\temp" directory. The split files are stored in the "C:\temp\Output" directory, and each split file will not exceed 2MB in size. 

## PARAMETERS

### -dateMask
The date format to be used in the names of the split files. Default value is "yyyy-MM-dd-HH-mm-ss-ffff".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inputPath
The path of the log file(s) to be split. It can include a file mask (e.g., "C:\temp\filezilla-server.*.log"). Mandatory parameter.

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

### -maxFileSize
The maximum size limit for the split files. Default value is 2MB.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -outputFolder
The path of the folder where the split files will be stored. Mandatory parameter.

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

### -outputMask
The naming pattern for the split files. Default value is "filezilla-server.{0}-{1}.log".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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


