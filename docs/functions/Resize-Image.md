---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Resize-Image.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Resize-Image

## SYNOPSIS
Changes the image size proportionally for jpg files

## SYNTAX

```
Resize-Image [[-pathIn] <String>] [[-pathOut] <String>] [-modifier <String>] [-quality <Int32>]
 [-maxWidth <Int32>] [-maxHeight <Int32>] [-passthru] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function changes the image size of jpg files proportionally. Via the parameters `maxWidth` and `maxHeight` the maximum size is specified. Depending on which dimension of the image is larger, this side is then set to the maximum value and the other side is proportionally adjusted to this size. If no dimension is specified, the default value of **1200** is used.
If no output path is specified, or if the output path is the same as the input path, the `modifier` is appended to the image name. The default value for the modifier is '-resized'. The quality of the resizing can be specified in the range 10 to 100. The default is 65.

If a directory containing jpg files is passed via **pipes** to the function, it is useful to specify an output path. Otherwise the name of the image is modified by the `modifier`. 
If the switch `passthru` is set, the new file names are returned as the function result.

The function is based on the Windows COM object `WIA.ImageFile` and `WIA.ImageProcess`. These are not installed by Windows Setup by default, but can be activated as a feature at any time. This is also possible on Windows servers. The setting is: `User Interface and Infrastructure`.

> If the destination image already exists, it will be overwritten. If the destination folder does not exist, it will not be created. Recursive piping is not supported, nor is the specification of non-Jpeg files.

## EXAMPLES

### Example 1:Resizes a image to the default size of 1200 pixels
```powershell
PS C:\> Resize-Image -pathIn C:\temp\john.jpg
```

The function resizes the image if a side is larger than the maximum width or height, where the default is 1200 pixels. No output path is specified, so the result is saved in the input folder, but with a modifier so that the new file is named C:\temp\john-resized.jpg.

## PARAMETERS

### -maxHeight
The max height of the new image in pixel. The default value is 1200. Values from 32 to 5000 are possible.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -maxWidth
The max width of the new image in pixel. The default value is 1200. Values from 32 to 5000 are possible.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -modifier
To avoid conflicts a `modifier` changes the file name of the new image. the default is `-resized`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -passthru
If this switch is set, the new filenames are returned as a object array of file names.

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

### -pathIn
The fully qualified input path of a image file, if piping is not used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -pathOut
The fully qualified output path of the new image. If the piping function is used, the output path must be specified without a filename.

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

### -quality
The image quality of the new image. The higher the value, the better the quality, but the larger the file size. The default value is 65. Values from 10-100 are possible.

```yaml
Type: Int32
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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


