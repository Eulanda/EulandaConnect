---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-NetworkId.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-NetworkId

## SYNOPSIS
Returns the Network ID from an IP with subnet mask

## SYNTAX

```
Get-NetworkId [[-ip] <String>] [[-subnet] <String>] [[-cidr] <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `Get-NetworkId` command retrieves the network ID for the specified IP address and subnet mask or CIDR. If **no** IP address or subnet mask/CIDR is specified, the command uses the **local IP address** and subnet mask. If successful, the command returns the network ID as a string. 

If an error occurs, it returns `0.0.0.0`.

## EXAMPLES

### Example 1:Returns the Network ID from an IP with subnet mask
```powershell
PS C:\> Get-NetworkId -ip '192.168.178.10' -subnet '255.255.255.0'
```

```ini
# Output

192.168.178.1
```

This example retrieves the network ID for the IP address `192.168.178.10` and subnet mask `255.255.255.0`.

## PARAMETERS

### -cidr
Specifies the CIDR notation for the subnet mask. If `subnet` is not specified, the command uses this value to determine the subnet mask.

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

### -ip
Specifies the IP address for which to retrieve the network ID. If not specified, the command uses the local IP address.

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
Specifies the subnet mask for the specified IP address. If not specified, the command attempts to determine the subnet mask using the local IP address and CIDR.

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


