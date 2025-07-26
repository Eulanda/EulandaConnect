---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Hostname.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-Hostname

## SYNOPSIS

Returns the hostname from a DNS request

## SYNTAX

```
Get-Hostname [[-ip] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Returns the hostname from a DNS request, which usually also resolves the IP of the local gateway. Note: If no IP is provided, the function attempts to obtain the local IP address.

## EXAMPLES

### Example 1:Determins the hostname by a DNS query
```powershell
PS C:\> Get-Hostname (Get-GatewayIp)
```

```ini
# Output

fritz.box
```

In this example, the IP address of the local gateway is determined, and then the hostname is obtained through a local DNS query.

## PARAMETERS

### -ip
Specifies the IP address for which to retrieve the host name. If not specified, the local IP address is used.

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


