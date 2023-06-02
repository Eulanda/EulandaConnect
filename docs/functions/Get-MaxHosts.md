---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-MaxHosts.md
schema: 2.0.0
---

# Get-MaxHosts

## SYNOPSIS
The Get-MaxHosts command retrieves the maximum number of hosts for the specified subnet mask

## SYNTAX

```
Get-MaxHosts [[-subnet] <String>] [[-cidr] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The `Get-MaxHosts` command retrieves the maximum number of hosts for the specified subnet mask or CIDR notation. If neither subnet mask nor CIDR notation is specified, the command uses the local subnet mask to calculate the maximum number of hosts.

If successful, the command returns the maximum number of hosts as an integer. If an error occurs, it returns `0`.

## EXAMPLES

### Example 1:retrieves the maximum number of hosts for the subnet mask 255.255.255.0
```powershell
PS C:\> Get-MaxHosts -subnet '255.255.255.0'
```

```ini
# Output

254
```

This example retrieves the maximum number of hosts for the subnet mask `255.255.255.0`.

## PARAMETERS

### -cidr
Specifies the CIDR notation for the subnet mask. If `subnet` is not specified, the command uses this value to determine the subnet mask.

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
Specifies the subnet mask for which to calculate the maximum number of hosts. If not specified, the command attempts to determine the subnet mask using the local IP address and CIDR.

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
