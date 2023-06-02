---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-HtmlStyle.md
schema: 2.0.0
---

# Get-HtmlStyle

## SYNOPSIS
Provides the EULANDA style for HTML pages and HTML emails

## SYNTAX

```
Get-HtmlStyle [<CommonParameters>]
```

## DESCRIPTION
Returns the default stylesheet delivered with EulandaConnect, which is used for HTML exports or HTML mails. It can be used directly in the `ConvertTo-Html` function.

## EXAMPLES

### Example 1:Returns  Eulanda stylesheet
```powershell
PS C:\> Get-HtmlSytle
```

```Xml
<style>
    html {
        margin:    0 auto;
        max-width: 800px;
    }
    body {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 14px;
    }
    h1 {
        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;
    }
    h2 {
        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;
    }
    h3 {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 16px;
    }
...
</style>
```

The function returns the default stylesheet used by `EulandaConnect` for HTML files or HTML.Mails.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
