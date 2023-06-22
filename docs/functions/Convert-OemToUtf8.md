---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-OemToUtf8.md
schema: 2.0.0
---

# Convert-OemToUtf8

## SYNOPSIS
Converts an input string from OEM (Original Equipment Manufacturer) encoding to UTF-8 encoding, with specific mappings for German special characters.

## SYNTAX

```
Convert-OemToUtf8 [-inputString] <String> [<CommonParameters>]
```

## DESCRIPTION
The function takes a string encoded in OEM and converts it to UTF-8, using mappings for specific German special characters.  The function loops through each character in the input string, checks if it corresponds to one of the specified OEM encoded characters,  and replaces it with the corresponding UTF-8 character.

## EXAMPLES

### Example 1
```powershell
PS C:\> Convert-OemToUtf8 -inputString 'Rckfahrt'
```

This command converts the input string 'Rckfahrt' from OEM to UTF-8, and returns 'Rückfahrt'.

## PARAMETERS

### -inputString
The input string to be converted from OEM to UTF-8 encoding. This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

The function was created to support legacy data formats, particularly the Datanorm standard, which still requires this type of conversion.  Datanorm is a German data format standard used in the commercial sector, especially in the building and electrical trades.  Despite its age, it is still in widespread use today.

## RELATED LINKS
