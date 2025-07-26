---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-XmlEulandaRoot.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-XmlEulandaRoot

## SYNOPSIS
Get-XmlEulandaRoot creates an XML root node for EULANDA_XML format

## SYNTAX

```
Get-XmlEulandaRoot [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-XmlEulandaRoot generates the root node for EULANDA_XML format, which reflects the fields of the main tables of the EULANDA ERP software for exchange between same or foreign systems, such as online shops. The root node is identical for all message types.

## EXAMPLES

### Example 1:Root for Eulanda Xml
```powershell
PS C:\> Get-XmlEulandaRoot
```

```xml
<EULANDA></EULANDA>
```

Function `Get-XmlEulandaRoot` generates an empty XML node for the EULANDA_XML format used for data exchange between EULANDA ERP-Software and other systems, such as online shops. The root node is identical for all message types and has the name "EULANDA". This node would be "<EULANDA></EULANDA>".

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


