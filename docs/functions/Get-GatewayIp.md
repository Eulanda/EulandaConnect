---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-GatewayIp.md
schema: 2.0.0
---

# Get-GatewayIp

## SYNOPSIS
Gets the IP address of the local gateway router

## SYNTAX

```
Get-GatewayIp [<CommonParameters>]
```

## DESCRIPTION
This function retrieves the IP address of the local gateway router by using the Get-NetRoute cmdlet to retrieve the routing table information for the IPv4 address family. It then filters the routing table to only include the default route, represented by the DestinationPrefix of "0.0.0.0/0". Finally, it selects the NextHop IP address of the default route, which represents the IP address of the local gateway router.

## EXAMPLES

### Example 1:Retrieves the IP address of the gateway
```powershell
PS C:\> Get-GatewayIp
```

```ini
# Output

192.168.178.1
```

Retrieves the IP address of the gateway

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
