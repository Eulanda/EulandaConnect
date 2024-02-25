---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Deny-RemoteFingerprint.md
schema: 2.0.0
---

# Deny-RemoteFingerprint

## SYNOPSIS
This PowerShell function compares the SSH key of a server with the one stored in the local cache (Trusted Hosts). Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Deny-RemoteFingerprint.ps1).

## SYNTAX

```
Deny-RemoteFingerprint [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Deny-RemoteFingerprint function compares the SSH key of a server with the one stored in the local cache (Trusted Hosts). By default, it supports only the SFTP protocol. However, the function is designed to accommodate future support for FTPS as well. The server parameter specifies the hostname or IP address of the server. The protocol parameter specifies the protocol to use, with 'sftp' being the default value.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Checks the SSH key against the trusted hosts
```powershell
PS C:\> Deny-RemoteFingerprint -server 'myftp.example.com'
```

Checks the SSH key of the server `myftp.example.com` against the one stored in the local cache (Trusted Hosts) using the default SFTP protocol. Returns true if the keys exist and are different.

## PARAMETERS

### -port
The port number to connect to on the remote server. This typically defaults to 21 for FTP and FTPS, or 22 for SFTP if not specified.

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

### -protocol
Specifies the protocol to use for connecting to the server. The default value is `sftp`. In future also `ftps` would be supported.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ftp, ftps, sftp

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -server
Specifies the hostname or IP address of the server.

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

