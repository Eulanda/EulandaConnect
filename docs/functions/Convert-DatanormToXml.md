---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-DatanormToXml.md
schema: 2.0.0
---

# Convert-DatanormToXml

## SYNOPSIS
Converts a Datanorm PowerShell object into an XML string that's compatible with the EULANDA merchandise management system.

## SYNTAX

```
Convert-DatanormToXml [[-datanorm] <Object>] [<CommonParameters>]
```

## DESCRIPTION
The Convert-DatanormToXml function accepts a Datanorm object as input, which represents the content of a Datanorm file, and converts it into an XML string that is compatible with the EULANDA merchandise management system. The resulting XML can be directly read by the EULANDA system. 

## EXAMPLES

### Example 1: Converts PowerShell Datanorm object to an EULANDA specific XML
```powershell
PS C:\> $xml = Convert-DatanormToXml -datanorm $datanorm
```

This command converts a Datanorm PowerShell object into an XML string that's compatible with the EULANDA merchandise management system.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

The EULANDA merchandise management system requires a specific XML format for data import. This function is designed to create an XML string that complies with this format based on the provided Datanorm object.

## RELATED LINKS
