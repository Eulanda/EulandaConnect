---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-FromDatanorm.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Convert-FromDatanorm

## SYNOPSIS
This PowerShell function converts a Datanorm 4.0 file into a structured PowerShell object - PsCustomObject. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-FromDatanorm.ps1).

## SYNTAX

```
Convert-FromDatanorm [[-path] <String>] [[-vat] <Double>] [[-cuDel] <Double>] [-utf8] [-show]
 [[-decimalSeparator] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function `Convert-FromDatanorm` reads a Datanorm file and converts it into a collection of PowerShell objects arranged in a hierarchical data structure. Currently, it can process the following types of records:

1. Type `V`: Version Data - Carries version information, date, and additional text information.
2. Type `A`: Basic Article Data - Includes basic information such as article number, description, price, unit, etc.
3. Type `B`: Additional Article Data - Includes supplementary details like alternative article number, weight, packaging amount, etc.
4. Type `P`: Price and Condition Data - Handles various price and condition information for an article.

The function is **still under development**. Future enhancements include handling long texts with insertions, bill of materials (BOM), and material surcharges. These additions will make the function more comprehensive and beneficial for processing Datanorm files.

## EXAMPLES

### Example 1:  Convert Datanorm file to a PowerShell object
```powershell
PS C:\> $datanorm = Convert-FromDatanorm -path "C:\Users\john\Desktop\datanorm\Test\datanorm.001"
```

This command converts a Datanorm file located at `C:\Users\john\Desktop\datanorm\Test\datanorm.001` into a PowerShell object `$datanorm`. The object represents the content of the Datanorm file and can be further processed or manipulated in PowerShell. It has the four properties `v`, `a`, `b` and `p`. 

### Example 2:  Shows the data for a specific article number
```powershell
PS C:\> $datanorm = Convert-FromDatanorm -path "C:\Users\john\Desktop\datanorm\Test\datanorm.001" -cuDel 879
PS C:\> $datanorm.a["8241335"]
PS C:\> $datanorm.b["8241335"]
PS C:\> $datanorm.a["8241335"].Kurztext1
```

```ini
# original datanorm dump
A;A;8241335;00;ELTROPA Verdrahtungsbr�cke 1ph 265mm sw;EVB 10/265 A2 10qmm Stift isol;1;0;Stk;257;EM01;01;;
B;A;8241335;EVB 10/265 A2;456 01 31;;1;150;250;4003899170225;;010204;0;1;;;

# PowerShell object from $datanorm.a["8241335"]
SatzKennzeichen          : A
VerarbeitungsKennzeichen : A
ArtikelNummer            : 8241335
TextKennzeichen          : 00
Kurztext1                : ELTROPA Verdrahtungsbrücke 1ph 265mm sw
Kurztext2                : EVB 10/265 A2 10qmm Stift isol
PreisKennzeichen         : 1
PreisEinheit             : 0
MengenEinheit            : Stk
Preis                    : 2,57
RabattGruppe             : EM01
WarenhauptGruppe         : 01
LangtextSchluessel       : 
EUL_PreisProStueck       : 2,57

# PowerShell object from $datanorm.b["8241335"]
SatzKennzeichen          : B
VerarbeitungsKennzeichen : A
ArtikelNummer            : 8241335
Matchcode                : EVB 10/265 A2
AlternativArtikelNummer  : 456 01 31
KatalogSeite             : 
CUGewichtsMerker         : 1
CUKennzahl               : 150
Gewicht                  : 2,50
EuroArtikelNummer        : 4003899170225
AnbindungsNummer         : 
WarenGruppe              : 010204
KostenArt                : 0
VerpackungsMenge         : 1
ReverenzKuerzel          : 
ReverenzNummer           : 
EUL_CuGewichtProStueck   : 0,025
EUL_CuAufschlagProStueck : 0,18225
EUL_CuDelPro100Kg        : 879

# PowerShell field object from $datanorm.a["8241335"].Kurztext1
ELTROPA Verdrahtungsbrücke 1ph 265mm sw
```

Via `$datanorm.a` the individual field values can be retrieved and also addressed directly by specifying the article number. The same applies to the other properties like `$datanorm.b` or `$datanorm.p`. Field designations with EUL contain adjusted values so that, for example, copper surcharges are displayed in unit terms.

## PARAMETERS

### -cuDel
Copper-DEL Notation, the price is in EUR per 100 kg copper. The price was in 02/2022 879 EUR for 100 kg copper.

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decimalSeparator
The decimal separator used in the Datanorm file. The default value is the current culture's number decimal separator.

```yaml
Type: String
Parameter Sets: (All)
Aliases: decimal

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
The path of the Datanorm file to be converted.

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

### -utf8
If this switch is set, an attempt is first made to open the Datanorm file as UTF8 (without BOM). If this fails, the file is opened as ANSI file. Datanorm is not available as Utf8 according to the documentation, but the first wholesalers output this encoding. The switch can usually not hurt, because there is an automatic fallback, but it should remain the exception and with a fallback it simply also takes longer to read. So use the switch only if you have problems with the character representation, which is ANSI according to the standard.

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

### -vat
The value-added tax rate. The default value is 19.0 %.

```yaml
Type: Double
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

Currently, this function supports Datanorm version 4.0 only. Despite Datanorm 4.0 being an older standard, it is still widely used and relevant in many industries, particularly in Germany's building and construction sector. It provides a comprehensive and universal standard for electronic product data exchange between manufacturers, wholesalers and craftsmen in the HVAC sector. Datanorm 4.0 covers the basic and most commonly used elements, such as general product data (type A), additional product data (type B), version data (type V), and price data (type P). 

Datanorm 5.0 introduces additional complexities and features that are not yet supported by this function. The newer version extends the possibilities for the transfer of multimedia content, logistics data, long texts and other additional information. Should there be sufficient demand for Datanorm 5.0 support, we may consider enhancing this function accordingly in the future. 

It is important to note that due to the complexity and variety of data, there might be special cases which this function does not cover. It is recommended to thoroughly test this function with your specific Datanorm files to ensure compatibility.

## RELATED LINKS

[Convert-FromDatanorm](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-FromDatanorm.ps1)






