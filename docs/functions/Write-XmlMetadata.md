---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Write-XmlMetaData.md
schema: 2.0.0
---

# Write-XmlMetadata

## SYNOPSIS
Writes a EULANDA metablock via XmlWriter

## SYNTAX

```
Write-XmlMetadata [[-writer] <Object>] [[-strCase] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function writes a EULANDA specific meta data block into a xml writer object. This function is called implicitly by `Convert-DataToXml` among others.

## EXAMPLES

### Example 1:Writes metadata using the xml writer object
```powershell
$encoding = [System.Text.Encoding]::UTF8
$settings = New-Object System.Xml.XmlWriterSettings
$settings.Indent = $true
$settings.IndentChars = "  "
$settings.Encoding = $encoding
$stream = New-Object System.IO.MemoryStream
$writer = [System.XML.XmlWriter]::Create($stream, $settings)

# Start with the root node
$writer.WriteStartDocument()
$writer.WriteStartElement('EULANDA')
$writer = Write-XmlMetadata -writer $writer -strCase 'upper'
...
```

```xml
<EULANDA>
	<METADATA>
        <VERSION>1.22</VERSION>/VERSION>
		<GENERATOR>EulandaConnect</GENERATOR>
		<DATEFORMAT>ISO8601</DATEFORMAT>
		<FLOATFORMAT>US</FLOATFORMAT>
		<COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
		<FIELDNAMES>NATIVE</FIELDNAMES>
		<DATE>2023-02-16T13:05:12</DATE>
		<PCNAME>PC4ALL</PCNAME>
		<USERNAME>DOE</USERNAME>
	</METADATA>
</EULANDA>
```

The metadata is written in conjunction with the xml writer object.

## PARAMETERS

### -strCase
By setting the parameter `strCase` you can influence the output. If the parameter is omitted or set to `none`, no further conversion is performed. With `lower` the output is converted to lowercase, with `upper` to uppercase and with `capitalize` the first letter of a word is output in uppercase.

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

### -writer
An instance of the object System.XML.XmlWriter

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

## RELATED LINKS

[Convert-DataToXml](../functions/Convert-DataToXml.md)




