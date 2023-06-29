---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-DatanormToXml.md
schema: 2.0.0
---

# Convert-DatanormToXml

## SYNOPSIS
This PowerShell function converts a Datanorm PsCustomObject into an XML string that's also compatible with the EULANDA merchandise management system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-DatanormToXml.ps1).

## SYNTAX

```
Convert-DatanormToXml [[-datanorm] <Object>] [-show] [<CommonParameters>]
```

## DESCRIPTION
The Convert-DatanormToXml function accepts a Datanorm object as input, which represents the content of a Datanorm file, and converts it into an XML string that is compatible with the EULANDA merchandise management system. The resulting XML can be directly read by the EULANDA system. 

## EXAMPLES

### Example 1: Converts PowerShell Datanorm object to an EULANDA specific XML
```powershell
PS C:\> $datanorm = Convert-FromDatanorm -path "C:\Users\john\Desktop\datanorm\Test\datanorm.001"
PS C:\> $xml = Convert-DatanormToXml -datanorm $datanorm
```

```xml
<EULANDA>
    <METADATA>
        <VERSION>3.2.1</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2023-06-23T15:38:00</DATE>
        <PCNAME>DADOSTUDIO</PCNAME>
        <USERNAME>CN</USERNAME>
    </METADATA>
    <ARTIKELLISTE>
        <ARTIKEL>
            <ARTNUMMER>8241335</ARTNUMMER>
            <ARTMATCH>EVB 10/265 A2</ARTMATCH>
            <BARCODE>4003899170225</BARCODE>
            <ARTNUMMERERSATZ>456 01 31</ARTNUMMERERSATZ>
            <VKNETTO>2.75</VKNETTO>
            <MENGENEH>Stk</MENGENEH>
            <VERPACKEH>1</VERPACKEH>
            <RABATTGR>EM01</RABATTGR>
            <WARENGR>01</WARENGR>
            <KURZTEXT1>ELTROPA Verdrahtungsbrücke 1ph 265mm sw</KURZTEXT1>
            <KURZTEXT2>EVB 10/265 A2 10qmm Stift isol</KURZTEXT2>
            <ULTRAKURZTEXT>ELTROPA Verdrahtungsbrücke 1ph 265mm sw</ULTRAKURZTEXT>
            <LANGTEXT>ELTROPA Verdrahtungsbrücke 1ph 265mm sw
EVB 10/265 A2 10qmm Stift isol</LANGTEXT>
        </ARTIKEL>
    </ARTIKELLISTE>
</EULANDA>
```

This command converts a Datanorm PowerShell object into an XML string that's compatible with the EULANDA merchandise management system. These files can be imported directly.

## PARAMETERS

### -datanorm
The Datanorm object to be converted. This should represent a Datanorm file that was previously converted using the Convert-FromDatanorm function.

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

### -show
Displays a progress bar during execution.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

The EULANDA merchandise management system requires a specific XML format for data import. This function is designed to create an XML string that complies with this format based on the provided Datanorm object.

## RELATED LINKS

[Convert-DatanormToXml.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-DatanormToXml.ps1)
