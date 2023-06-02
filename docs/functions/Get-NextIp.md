---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-NextIp.md
schema: 2.0.0
---

# Get-NextIp

## SYNOPSIS
The `Get-NextIp` command retrieves the next IP address after the specified IP address by incrementing

## SYNTAX

```
Get-NextIp [[-ip] <String>] [[-inc] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get-NextIp command retrieves the next IP address after the specified IP address. By default, it retrieves the IP address that immediately follows the specified IP address, but you can specify a different increment value using the `-inc` parameter.

If successful, the command returns the next IP address as a string. If an error occurs, it returns `0.0.0.0`.

## EXAMPLES

### Example 1:et-NextIp command retrieves the next IP address after the specified IP
```powershell
PS C:\> Get-NextIp -ip '192.168.178.1' -inc 14
```

```ini
# Output

192.168.178.15
```

This example retrieves the IP address that is 14 addresses after `192.168.178.1`.

## PARAMETERS

### -inc
Specifies the increment value to use when calculating the next IP address. The default value is 1.

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

### -ip
Specifies the IP address for which to retrieve the next IP address.

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
