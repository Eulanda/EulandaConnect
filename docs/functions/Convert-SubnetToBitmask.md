---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-SubnetToBitmask.md
schema: 2.0.0
---

# Convert-SubnetToBitmask

## SYNOPSIS
This PowerShell function converts a subnet mask or CIDR to its bit representation. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-SubnetToBitMask.ps1).

## SYNTAX

```
Convert-SubnetToBitmask [[-subnet] <String>] [[-cidr] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This function converts the subnet mask or CIDR to its bit representation. If neither `$subnet` nor `$cidr` is provided, the function gets the subnet mask from the local IP address.

## EXAMPLES

### Example 1:Representation of the subnet mask
```powershell
PS C:\> Convert-SubnetToBitmask -subnet '255.255.255.0'
```

```ini
# Output

11111111111111111111111100000000
```

The output is a string representing the bit representation of the subnet mask or CIDR.

## PARAMETERS

### -cidr
The CIDR notation (e.g., 24 for a subnet mask of 255.255.255.0).

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

### -subnet
The subnet mask in IP address format (e.g., 255.255.255.0).

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
