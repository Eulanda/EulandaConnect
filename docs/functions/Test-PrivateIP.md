---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-PrivateIp.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-PrivateIp

## SYNOPSIS
Tests whether the specified IP belongs to a private network.

## SYNTAX

```
Test-PrivateIp [[-ip] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function tests whether the specified IP number belongs to a private network. A total of three private networks have been reserved that are not routed to the Internet.

## EXAMPLES

### Example 1:Testing if the IP belongs to a private address
```powershell
PS C:\> Test-PrivateIp -ip '192.168.178.1'
```

The function returns `true` in this case, because the IP `192.168.178.1` belongs to a private network.

## PARAMETERS

### -ip
IP address to test for.

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


