---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-BroadcastIp.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-BroadcastIp

## SYNOPSIS
This PowerShell function calculate the broadcast IP of a given network. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-BroadcastIp.ps1).

## SYNTAX

```
Get-BroadcastIp [[-networkId] <String>] [[-ip] <String>] [[-subnet] <String>] [[-cidr] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function `Get-BroadcastIp` is used to calculate the broadcast IP of a given network. This information is commonly used to send a message to all devices within a particular network. The function takes either a network ID, an IP address, a subnet mask, or a CIDR as input parameters, and it returns the broadcast IP for that network.

## EXAMPLES

### Example 1:Returns the broadcast IP address for the network ID 192.168.178.0 /24
```powershell
PS C:\> Get-BroadcastIp -networkId 192.168.178.0 -cidr 24
```

```ini
# Output

192.168.178.255
```

This example returns the broadcast IP address for the network ID 192.168.178.0 with a subnet mask of 255.255.255.0 or the equivalent CIDR of 24. The broadcast IP address is the last address in the network range and is used for sending messages to all devices on the network at once.

## PARAMETERS

### -cidr
The CIDR notation of the network for which you want to calculate the broadcast IP.

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
An IP address in the network for which you want to calculate the broadcast IP.

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
The network ID of the network for which you want to calculate the broadcast IP.

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
The subnet mask of the network for which you want to calculate the broadcast IP.

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


