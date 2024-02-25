---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-FirstIp.md
schema: 2.0.0
---

# Get-FirstIp

## SYNOPSIS
First usable IP address of the subnet

## SYNTAX

```
Get-FirstIp [[-networkId] <String>] [[-ip] <String>] [[-subnet] <String>] [[-cidr] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get-FirstIp function returns the first usable IP address of the subnet, which can be determined using either a specified network ID or an IP address and subnet mask. If neither of these is provided, the subnet is obtained from the local IP address.

## EXAMPLES

### Example 1:Determine first usable IP address of the subnet
```powershell
PS C:\> Get-FirstIp -networkId 192.168.178.0 -cidr 24
```

```ini
# Output

192.168.178.1
```

In this example, a classic home network is specified by using the typical network ID of a Fritzbox. The CIDR corresponds to a complete C class network.

## PARAMETERS

### -cidr
Specifies the subnet mask of the network in CIDR format. If not provided, the subnet is obtained from the IP address.

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
Specifies the IP address to be used for obtaining the subnet mask.

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
Specifies the network ID of the subnet.

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
Specifies the subnet mask of the network.

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

