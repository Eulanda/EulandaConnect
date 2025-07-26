---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Format-Xml.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Format-Xml

## SYNOPSIS
This PowerShell function formats or beautifies an XML string or file by applying indentation and encoding. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Format-Xml.ps1).

## SYNTAX

```
Format-Xml [[-xmlString] <String>] [[-pathIn] <String>] [[-pathOut] <String>] [-removeDecoration]
 [-setDecoration] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Format-Xml` function formats an XML string or file by applying indentation and encoding. If the `xmlString` parameter is provided, the function formats it as an XML string. If the `pathIn` parameter is provided, the function reads the content of the XML file and formats it. The formatted XML output can be either returned or saved to a file, as specified by the `pathOut` parameter. 

## EXAMPLES

### Example 1:Format an XML string and output it to the console
```powershell
PS C:\> Format-Xml -xmlString "<root><child>Hello John Doe!</child></root>" -setDecoration
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<root>
    <child>Hello John Doe!</child>
</root>
```

Format an XML string and output it to the console.

### Example 2:Format an XML file and save it to a new file
```powershell
PS C:\> Format-Xml -pathIn "C:\xml\source.xml" -pathOut "C:\xml\formatted.xml" -removeDecoration
```

```xml
<root>
    <child>Hello John Doe!</child>
</root>
```

The function `Format-Xml` formats an XML file and saves it to a new file. The content of the file is passed as input and has no decoration.

### Example 3:Format an XML string and save it to a file
```powershell
PS C:\> Format-Xml -xmlString "<root><child/></root>" -pathOut "C:\xml\formatted.xml"
```

Format an XML string and save it to a file.

## PARAMETERS

### -pathIn
Specifies the path to the XML file to format. This parameter is mutually exclusive with the `xmlString` parameter.

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

### -pathOut
Specifies the path to the file where the formatted XML will be saved. If this parameter is not provided, the formatted XML will be returned as a string. 

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

### -removeDecoration
If this parameter is set, the declaration will always be removed, even if it not was originally present in the input XML.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -setDecoration
The parameter adds the XML declaration to the output XML string. If this parameter is set, the declaration will always be added, regardless of whether it was originally present in the input XML or not. The outfput encoding is always utf8, so the decoration is like: <?xml version="1.0" encoding="utf-8" standalone="yes"?>.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -xmlString
Specifies the XML string to format. This parameter is mutually exclusive with the `pathIn` parameter.

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


