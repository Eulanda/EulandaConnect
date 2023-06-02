---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-WrappedLines.md
schema: 2.0.0
---

# ConvertTo-WrappedLines

## SYNOPSIS
Performs a wrap of a text

## SYNTAX

```
ConvertTo-WrappedLines [[-text] <String>] [[-width] <Int32>] [-asString] [-useCrLf] [<CommonParameters>]
```

## DESCRIPTION
Performs a wrap of a text. The maximum width can be specified with `width`. If an overlong word is found, which is longer than the specified `width`, the word will be split at the maximally necessary position.

The output is an array of strings, but it is also possible to get the value as a string with line feeds by setting the switch `asString`. Optionally the string can also get carriage-return and line-feeds, as it is common under Windows, by setting the `useCrLf` switch.

## EXAMPLES

### Example 1:Performs a wrap of a text with a width of 40
```powershell
PS C:\> $myText = 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.'
PS C:\> $newLines= ConvertTo-WrappedLines -text $myText -width 40
PS C:\> $newLines
```

```ini
#Output

Lorem ipsum dolor sit amet, consetetur
sadipscing elitr, sed diam nonumy
eirmod tempor invidunt ut labore et
dolore magna aliquyam erat, sed diam
voluptua.
```

The text specified in the `myText` variable is wrapped to the maximum width of 40 specified in `width`. 

## PARAMETERS

### -asString
This switch is used to specify that the output is not an array but a string. With a string the individual lines are separated by CRLF or LF.

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

### -useCrLf
If the return is a string, the lines are separated by LF (line feeds), as is common under Linux. If the switch is set, the separation is done by CRLF (carriage return + line feed), as it is usual under Windows.

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

### -width
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
