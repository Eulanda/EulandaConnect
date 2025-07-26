---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-LoremIpsum.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-LoremIpsum

## SYNOPSIS
The Get-LoremIpsum function generates a specified number of paragraphs of lorem ipsum text.

## SYNTAX

```
Get-LoremIpsum [[-minParagraphs] <Int32>] [[-maxParagraphs] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-LoremIpsum function generates a specified number of paragraphs of lorem ipsum text, which is commonly used as placeholder text in design and publishing applications. The function uses the "lorem ipsum" text generator to create the text. The generated text is returned as a string.

## EXAMPLES

### Example 1:Generates a specified number of paragraphs of lorem ipsum
```powershell
PS C:\> Get-LoremIpsum -MinParagraphs 2 -MaxParagraphs 4
```

This example generates 2 to 4 paragraphs of lorem ipsum text and returns the text as a string.

## PARAMETERS

### -maxParagraphs
MaxParagraphs (optional): Specifies the maximum number of paragraphs to generate. If not specified, the default value of 5 is used. The parameter accepts integer values.

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

### -minParagraphs
MinParagraphs (optional): Specifies the minimum number of paragraphs to generate. If not specified, the default value of 1 is used. The parameter accepts integer values.

```yaml
Type: Int32
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

- The MinParagraphs parameter must be less than or equal to the MaxParagraphs parameter.
- If both parameters are not specified, the function generates one paragraph of lorem ipsum text by default.

## RELATED LINKS


