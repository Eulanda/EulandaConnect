---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Find-MssqlServer.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Find-MssqlServer

## SYNOPSIS
This PowerShell function searches for all SQL-Servers in a specified IP range. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Find-MssqlServer.ps1).

## SYNTAX

```
Find-MssqlServer [[-localIp] <String>] [[-remoteIp] <String>] [[-udpPort] <Int32>] [[-timeoutSeconds] <Int32>]
 [-force] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function searches for all SQL-Servers in a specified IP range and returns the found IPs, Instance Name, the found SQL-Server Version and if TCP is enabled. The output is a **PSCustomObject** and is directly compatible for piping into an `Out-GridView`. Alternatively, you can specify only the `-fromIP`, then a single broadcast is sent. If nothing is specified, the local network configuration is evaluated (network ID and CIDR) and the entire subnet is scanned.

## EXAMPLES

### Example 1:This will display the output in a table format
```powershell
PS C:\> Find-MssqlServer | Format-Table
```

```
Ip              ServerName InstanceName IsClustered Version     tcp   np
--              ---------- ------------ ----------- -------     ---   --
192.168.178.10  STUDIO     EULANDA      No          12.0.6024.0 60983 \\STUDIO\pipe\MSSQL$EULANDA\sql\query
192.168.178.10  STUDIO     SQL2019      No          15.0.2000.5 61310 \\STUDIO\pipe\MSSQL$SQL2019\sql\query
192.168.178.16  GO         EULANDA      No          15.0.2000.5 52894 \\GO\pipe\MSSQL$EULANDA\sql\query
```

Without specifying any parameters, the function will scan the entire subnet for SQL-Servers. The output can be piped to an `Out-GridView`. Instead of sending the output of `Find-MssqlServer` to a `GridView`, it can be formatted and displayed on the console using `Format-Table`, `Format-List`, or other formatting cmdlets.

### Example 2:This will display the output in a table format

```powershell
PS C:\> Find-MssqlBrowser -fromIp (Get-LocalIp) -toIp (Get-LocalIp)
```

```ini
Ip           : 192.168.178.10
ServerName   : STUDIO
InstanceName : EULANDA
IsClustered  : No
Version      : 12.0.6024.0
tcp          : 60983
np           : \\STUDIO\pipe\MSSQL$EULANDA\sql\query

Ip           : 192.168.178.20
ServerName   : STUDIO
InstanceName : SQL2019
IsClustered  : No
Version      : 15.0.2000.5
tcp          : 61310
np           : \\STUDIO\pipe\MSSQL$SQL2019\sql\query
```

Displays the local instances found through the SQL Browser service. The local IP is obtained through the `Get-LocalIp` function.

## PARAMETERS

### -force
If the parameter is set, the SQL browser service will be started if it was not started. However, if the service is disabled, then an exception is thrown.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -localIp
If the local IP is not specified, the SQL servers are searched on the local PC, if you specify 0.0.0.0, the local network is searched. The network interface assigned to the default gateway is used here.

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

### -remoteIp
If you know of a remote IP that is bound on one of your network interfaces but is not on the local network, you can specify it. This is often a VPN connection to a remote SQL server.

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

### -timeoutSeconds
Specifies the maximum time in seconds to wait for a response from IP address. The default value is 2 seconds.

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

### -udpPort
Specifies the port number to scan for SQL Browser services. The default value is 1434 for the standard UDP-Port of the SQL-Browser service.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


