---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-ReservedIp.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-ReservedIp

## SYNOPSIS
This function checks whether a given IP address is a part of the reserved IP address ranges. The IP address must be passed as a string.

## SYNTAX

```
Test-ReservedIp [[-ip] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Test-ReservedIP` function is a utility that is designed to evaluate if an IP address belongs to the reserved IP address ranges, which include private networks, loopback addresses, and other specific ranges reserved for documentation and example code, network benchmark tests, IETF protocol assignments, etc.

The function checks whether the given IP address falls within any of the predefined IP ranges. If the address matches any of these ranges, the function returns `true`; otherwise, it returns `false`.

This function only checks if an IP address is within the reserved ranges. It does not perform any network operations using the IP address, such as pinging or opening a network connection.

The list of reserved IP ranges used by the function includes commonly known ranges such as private networks (10.0.0.0 - 10.255.255.255, 172.16.0.0 - 172.31.255.255, 192.168.0.0 - 192.168.255.255) and loopback addresses (127.0.0.0 - 127.255.255.255), among others.

Please note that these ranges are as per the standards defined by the Internet Engineering Task Force (IETF) and the Internet Assigned Numbers Authority (IANA) as of the date of function creation.

## EXAMPLES

### Example 1: Tests if the ip is a reserved ip address
```powershell
PS C:\> Test-ReservedIP -ip '127.0.0.0'
```

In the above example, the IP address '127.0.0.0' is a loopback address, and so it is part of the reserved IP ranges. Therefore, the function will return `true`.

## PARAMETERS

### -ip
This parameter expects the IP address to be checked as a string.

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


