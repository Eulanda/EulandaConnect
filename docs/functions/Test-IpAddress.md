---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-IpAddress.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:26
---

# Test-IpAddress

## SYNOPSIS
This function validates whether a given string is a valid IPv4 address.

## SYNTAX

```
Test-IpAddress [[-ip] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Test-IpAddress` function is used to determine whether a given string is a valid IPv4 address or not. The function uses a regular expression pattern to match the input string against the IPv4 addressing format.

The function checks if the input string matches the format of an IPv4 address. If the string is a valid IPv4 address, the function will return `true`. If the string does not match the format of an IPv4 address, the function will return `false`.

The function checks the format of an IPv4 address but does not verify whether the address is in use or reachable. Please ensure that the input is an IPv4 address. This function will not work correctly for an IPv6 address.

The IPv4 addressing format used for validation by this function is as per the standards defined by the Internet Engineering Task Force (IETF).

## EXAMPLES

### Example 1: Checks whether -ip is a valid
```powershell
PS C:\> Test-IpAddress -Ip '260.1.2.3'
```

In this example, the function checks whether '260.1.2.3' is a valid IPv4 address. Since 260 is outside the range of an octet (0-255), the function will return `false`.

## PARAMETERS

### -ip
This parameter expects the string that will be checked for validity as an IPv4 address.

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

