---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-HtmlEncoded.md
schema: 2.0.0
---

# Get-HtmlEncoded

## SYNOPSIS
Returns an HTML-encoded string

## SYNTAX

```
Get-HtmlEncoded [[-taggedString] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns an HTML-encoded string, but it can contain simple HTML commands like bold, italics, lists, etc. These remain in the output as HTML.

## EXAMPLES

### Example 1:Encodes a tagged string
```powershell
PS C:\> Get-HtmlEncoded -taggedString 'Transferred with umlauts "öäü" <b>and</b> 30 >= 15'
```

```ini
# Output

Transferred with umlauts &quot;&#246;&#228;&#252;&quot; <b>and</b> 30 &gt;= 15
```

In this example, HTML tags like bold with `<b>` are passed through transparently, but other things like a single greater-than sign are encoded. Also special characters like **umlauts**. 

## PARAMETERS

### -taggedString
The string may contain simple tagged HTML. This includes, <b>, <i>, <ul>, <li>,<ol>,<p>,<pre> and like headings <h1> to <h5>.

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
