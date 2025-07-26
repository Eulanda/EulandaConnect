---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Subnet.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-Subnet

## SYNOPSIS
Get-Subnet command retrieves the subnet mask of a specified IP address CIDR

## SYNTAX

```
Get-Subnet [[-cidr] <Int32>] [[-localIp] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-Subnet command retrieves the subnet mask of the local IP address by default. You can also specify a specific locally available IP address, for example, from a VPN or virtual switch. Alternatively, you can specify a CIDR to convert the subnet mask.

If no parameters are specified, the command attempts to determine the local IP address and uses the subnet mask from the network interface of the local IP address.

## EXAMPLES

### Example 1:Retrieve the subnet mask for the local IP address.
```powershell
PS C:\> Get-Subnet
```

```ini
# Output

255.255.255.0
```

If no parameters are specified, the command attempts to determine the local IP address and uses the subnet mask from the network adapter. If there are multiple local IP addresses, the gateway is evaluated. If the gateway is in the same subnet as one of the locally determined IP addresses, that IP address is used. Otherwise, any locally found IP address is used.

## PARAMETERS

### -cidr
Specifies the CIDR notation for the subnet mask. If both the IP address and CIDR are specified, the CIDR notation is used to calculate the subnet mask.

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

### -localIp
If no parameters are specified, the command attempts to determine the local IP address and uses the subnet mask from the network adapter. If there are multiple local IP addresses, the gateway is evaluated. If the gateway is in the same subnet as one of the locally determined IP addresses, that IP address is used. Otherwise, any locally found IP address is used.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


