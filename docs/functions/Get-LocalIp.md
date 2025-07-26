---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-LocalIp.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-LocalIp

## SYNOPSIS
Get-LocalIp attempts to determine the local IP address

## SYNTAX

```
Get-LocalIp [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-LocalIp attempts to determine the local IP address by matching it with the gateway address. It first retrieves the gateway address using the `Get-GatewayIp` function. Then, it retrieves all IPv4 addresses assigned to the network interfaces that have been assigned either manually or through DHCP. For each address, it retrieves the subnet mask using the `Get-Subnet` function and checks if the bitwise AND between the IP address and the subnet mask matches the bitwise AND between the gateway address and the subnet mask. If a match is found, the IP address is returned. If no match is found, the function returns "0.0.0.0".

## EXAMPLES

### Example 1:Retrieves the local ip address
```powershell
PS C:\> Get-LocalIp
```

```ini
# Output

192.168.178.10
```

Retrieves the local ip address.

## PARAMETERS


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


