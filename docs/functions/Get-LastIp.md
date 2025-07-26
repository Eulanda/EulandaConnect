---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-LastIp.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-LastIp

## SYNOPSIS
Returns the last possible IP for a host for a given submask or cidr

## SYNTAX

```
Get-LastIp [[-networkId] <String>] [[-ip] <String>] [[-subnet] <String>] [[-cidr] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
These functions allow you to work with IP addresses and subnets. The `Get-LocalIp` function tries to determine the local IP address by matching it with the gateway IP. The `Get-NetworkId` function determines the network ID of a given IP address, subnet, or CIDR. The `Get-MaxHosts` function calculates the maximum number of hosts that can be assigned to a subnet. The `Get-LastIp` function determines the last usable IP address in a given subnet by using the network ID and maximum number of hosts.

## EXAMPLES

### Example 1:Returns the last possible IP for a host for a given cidr
```powershell
PS C:\> Get-LastIp -networkId 192.168.178.0 -cidr 24
```

```ini
# Output

192.168.178.254
```

Returns the last usable IP address of a given subnet, based on the network ID and the CIDR prefix length. If the network ID is not specified, it is determined using the provided IP address and subnet mask, or the local IP and subnet mask. If the CIDR prefix length is not specified, it is determined using the provided subnet mask or the subnet mask of the local IP.

## PARAMETERS

### -cidr
Specifies the CIDR notation for which to calculate the last IP address. If not provided, the function will try to determine the CIDR notation from the subnet mask.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ip
Specifies the local IP address for which to calculate the last IP address. If not provided, the function will try to determine the local IP address.

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

### -networkId
Specifies the network ID for which to calculate the last IP address. If not provided, the local IP address will be used to calculate the network ID.

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

### -subnet
Specifies the subnet mask for which to calculate the last IP address. If not provided, the function will try to determine the subnet mask from the local IP address.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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


