---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-XmlSchema.md
schema: 2.0.0
---

# Test-XmlSchema

## SYNOPSIS
Tests an xml schema against an xml file

## SYNTAX

```
Test-XmlSchema [[-xmlFile] <String>] [[-schemaFile] <String>] [<CommonParameters>]
```

## DESCRIPTION
Tests whether an XML file conforms to its schema.

## EXAMPLES

### Example 1:Tests if the xml file is valid against the specified schema
```powershell
PS C:\> if (Test-XmlSchema -xmlFile 'C:\temp\article.xml' -schemaFile 'C:\temp\article.xsd' ) { Write-Host 'XML file is valid' } else { 'XML file is not valid' }
```

This can be used to test whether the XML file corresponds to the specified schema. 

## PARAMETERS

### -schemaFile
Name incl. path to the xsd schema file.

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

### -xmlFile
Name incl. path to the xml file.

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

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
