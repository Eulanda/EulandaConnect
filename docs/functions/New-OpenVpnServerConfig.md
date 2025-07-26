---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-OpenVpnServerConfig.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-OpenVpnServerConfig

## SYNOPSIS
Generates a new OpenVPN server configuration file.

## SYNTAX

```
New-OpenVpnServerConfig [[-openVpnPath] <String>] [[-destination] <String>] [[-hostname] <String>]
 [[-networkAddress] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `New-OpenVpnServerConfig` function generates a new OpenVPN server configuration file based on a template file. The function customizes the default template by inserting specific values such as the server's hostname and network address. The generated file can then serve as a basis for creating OpenVPN server and client certificates.

## EXAMPLES

### Example 1: Generates a new OpenVPN server configuration
```powershell
PS C:\> New-OpenVpnServerConfig -openVpnPath "C:\Program Files\OpenVPN" -destination "$home\.eulandaconnect\OpenVPN" -hostname "myserver" -networkAddress '192.168.40.0'
```

```
# CONFIGURED SERVER myserver.ovpn
...
# The server will take 10.8.0.1 for itself,
# the rest will be made available to clients.
# Each client will be able to reach the server
# on 10.8.0.1. Comment this line out if you are
# ethernet bridging. See the man page for more info.
server 192.168.40.0 255.255.255.0

# Maintain a record of client <-> virtual IP address
# associations in this file.  If OpenVPN goes down or
...
```

Generates a new OpenVPN server configuration file with the specified path, destination folder, hostname, and network address.

## PARAMETERS

### -destination
Specifies the destination folder where the new configuration file will be written. The default is "$($home)\.eulandaconnect\OpenVPN".

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

### -hostname
Specifies the hostname of the server. The default is the hostname of the current machine.

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

### -networkAddress
Specifies the network address of the remote server. The default is '192.168.40.0'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -openVpnPath
Specifies the path to the OpenVPN installation. The default is "$($env:ProgramFiles)\OpenVPN".

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


