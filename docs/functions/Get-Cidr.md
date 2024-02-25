---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Cidr.md
schema: 2.0.0
---

# Get-Cidr

## SYNOPSIS
This PowerShellfunction calculates the CIDR based on the subnet. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-Cidr.ps1).

## SYNTAX

```
Get-Cidr [[-subnet] <String>] [[-ip] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function calculates the CIDR based on the subnet provided. If no subnet is provided, it attempts to obtain the local IP and the subnet mask from the network interface. The CIDR is a method of representing the subnet mask as a single number that expresses the number of bits in the mask. For example, a subnet mask of 255.255.255.0 can be represented as a CIDR of /24.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-Cidr
```

```ini
# Output

24
```

In this example, no parameter is specified. The local IP address is then determined and the subnet mask is obtained from the network interface associated with that IP. In the example, the command was run in a local network based on a Fritzbox. The default gateway IP in such a network is typically 192.168.178.1, and the subnet mask is usually 255.255.255.0.

CIDR (Classless Inter-Domain Routing) is a method for allocating IP addresses and routing Internet Protocol packets. It replaces the previous system based on classes A, B, and C. CIDR notation is a compact representation of an IP address and its associated network mask. It is expressed in the form of IP address followed by a slash and a number which represents the length of the prefix mask.

## PARAMETERS

### -ip
(optional): Specifies the IP address to be used to calculate the CIDR. If this parameter is not specified, the function will try to determine the local IP address and calculate the CIDR based on the subnet mask of the associated network interface.

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

### -subnet
(optional): Specifies the subnet mask to be used to calculate the CIDR. If this parameter is not specified, the function will try to determine the local subnet mask based on the local IP address and associated network interface.

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

