---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Select-OutdatedFilenames.md
schema: 2.0.0
---

# Select-OutdatedFilenames

## SYNOPSIS
Selects outdated filenames based on a specified basename and extension.

## SYNTAX

```
Select-OutdatedFilenames [[-filenames] <String[]>] [[-basename] <String>] [[-extension] <String>]
 [[-history] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Select-OutdatedFilenames function filters a list of filenames based on a given basename and extension. It then selects the outdated filenames by comparing the date portion in the filenames. The number of outdated filenames to be retained can be specified using the 'history' parameter.

You can use the function by providing the array of filenames to filter, the basename to match, and the extension to match. Optionally, you can specify the number of outdated filenames to retain using the `history` parameter. The function will return the filtered and selected outdated filenames.

The function is helpful when you have a list of filenames with a specific format and you want to filter and select only the outdated filenames based on the basename and extension.

Filename should follow the pattern 'yyyy-MM-dd-HH-mm-ss-ffff'. The expected filenames should have the following format: `(basename)-yyyy-MM-dd-HH-mm-ss-ffff(.extension)`. For example, `MyDatabase-2023-05-15-10-30-0001.zip`.

## EXAMPLES

### Example 1
```powershell
$filenames = @('MyDatabase-2023-05-15-10-30-0001.zip', 'OtherFile.txt', 'MyDatabase-2023-05-15-11-45-0002.zip')
$selectedFiles = Select-OutdatedFilenames -Filenames $filenames -basename 'MyDatabase' -extension '.zip' -history 1
```

This example selects the outdated filenames from the given list of filenames. It filters the filenames based on the specified basename 'MyDatabase' and the extension '.zip'. The 'history' parameter is set to 1, indicating that the one most recent outdated filename(s) should be retained.

## PARAMETERS

### -basename
Specifies the basename that the filenames should start with.

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

### -extension
Specifies the file extension that the filenames should end with, including the extension point.

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

### -filenames
Specifies an array of filenames to filter.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -history
(Optional) Specifies the number of outdated filenames to retain. Defaults to 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

