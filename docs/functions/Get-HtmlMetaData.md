---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-HtmlMetaData.md
schema: 2.0.0
---

# Get-HtmlMetaData

## SYNOPSIS
Provides an EULANDA specific set of meta information

## SYNTAX

```
Get-HtmlMetaData [[-description] <String>] [<CommonParameters>]
```

## DESCRIPTION
Provides EULANDA specific meta information as hash table. These are standard meta fields like `author`, `generator`, `keywords` and `viewport`. With the parameter Description a `description` can be added optionally.

## EXAMPLES

### Example 1:Returns HTML metadata including the description field.
```powershell
PS C:\> Get-HtmlMetadata -description 'This is my special description'
```

```ini
# Output

Name                           Value
----                           -----
author                         EULANDA Software GmbH - ERP-Systems - Germany
generator                      Powershell 7.3.2 by function ConvertTo-Html
keywords                       eulanda, erp, powershell, convertto-html, html
description                    This is my special description
viewport                       width=device-width, initial-scale=1.0
```

Here, the `description` parameter was additionally specified. The result is a hash list that can be used directly in the `ConvertTo-Html` function.

## PARAMETERS

### -description
The `description` parameter allows an individual output of the metadata. It contains the identically named `description` metafield.

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
