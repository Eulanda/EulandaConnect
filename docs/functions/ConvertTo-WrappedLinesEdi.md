---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-WrappedLinesEdi.md
schema: 2.0.0
---

# ConvertTo-WrappedLinesEdi

## SYNOPSIS
This PowerShell function creates two lines of text from a long continuous text, often used in EDI systems. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/ConvertTo-WrappedLinesEdi.ps1).

## SYNTAX

```
ConvertTo-WrappedLinesEdi [[-text] <String>] [[-Width] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The first two lines are extracted from a continuous text. Various optimizations are performed to obtain the relevant information. Overlong lines are wrapped. The continuous text can be passed either with **LF** as with Linux or with **CRLF** in lines separated. This separation is taken into account in the conversion.
The maximum line length can be set via Width, where the default value is 80 characters. This kind of separation is especially needed for EDI. The lines are there `al` for the first line and `a1` for the second line. If a text needs to be truncated because it is too long, three dots are placed at the end to indicate this. The **result** is passed as a **string array**.

## EXAMPLES

### Example 1:Separates a text into two relevant lines
```powershell
PS C:\> ConvertTo-WrappedLinesEdi -text "This is my house, but it is also my castle.`nBut anyway my car is also my car" -width 30
```

```ini
# Output

This is my house, but it is
also my castle. But anyway ...
```

The text had to be wrapped. The last line was also cut off and therefore three dots were added at the end. The result is an array of strings.

## PARAMETERS

### -Width
Specifies the maximum width of a line.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -text
The text to be wrapped is passed as a string. This can already contain line breaks like CRLF or LF. These are removed and the wrap is recalculated.

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
