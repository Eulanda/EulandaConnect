---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-FieldTruncated.md
schema: 2.0.0
---

# Get-FieldTruncated

## SYNOPSIS
Truncates a database field from an ADO recordset

## SYNTAX

```
Get-FieldTruncated [[-rs] <Object>] [[-fieldname] <String>] [[-maxLen] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function truncates a string from a field of a record set. It is usually used in XML data output to keep the code clearly arranged.

## EXAMPLES

### Example 1:Returns a shortened string from an ADO record set
```powershell
PS C:\> [string]$value= Get-FieldTruncated -rs $rs -fieldName 'Match' -maxLen 4
```

For example, if the `Match` field contains the content `John Doe` and it is to be truncated to the maximum length of 4, it returns the string `John`.

## PARAMETERS

### -fieldname
Field name of an ADO record set

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -maxLen
Maximum length that the text field of the ADO record set may have.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rs
The ADO record set is passed as parameter `rs`.

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

## RELATED LINKS

