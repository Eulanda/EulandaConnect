---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-MssqlInstances.md
schema: 2.0.0
---

# Get-MssqlInstances

## SYNOPSIS
Provides information about the MSSQL instances and their database files

## SYNTAX

```
Get-MssqlInstances [-show] [<CommonParameters>]
```

## DESCRIPTION
The function returns various information for each local instance of the MSSQL server as `PSCustomObject`. In addition, the Files property of each object is filled with the file properties of the instance. This includes the date of the last file modification as well as the size of the database.

The data is mainly accessed via the registry. In addition, the status values of the SQL service and the SQL browser are evaluated. 

If the query is performed with administrative rights, it is also checked whether the firewall has opened the UDP port of the SQL browser and whether there is a firewall rule for the SQL server service.

The information is additionally displayed on the monitor via the Show parameter.

> The advantage of the PSCustomObject data type over a hashtable is, for example, the simple access to the property names such as: $instances[1].PatchLevel as well as further processing with Format-Table and Format-List.

## EXAMPLES

### Example 1:Shows information about the MSSQL instances
```powershell
PS C:\> $instances= Get-MssqlInstances -show
```

```ini
# Output from within the function

SERVER SETTINGS FOR: [ SQL2019 ]

Instance          : SQL2019
Version           : 15.0.2000.5
PatchLevel        : 15.0.4298.1
Collation         : Latin1_General_CI_AS
BinnPath          : C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\Binn
DataPath          : C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\DATA
BackupPath        : C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\Backup
SqlService        : Running
BrowserService    : Stopped
NamedPipes        : True
TcpIp             : True
SharedMemory      : True
FirewallValid     : False
FirewallBrowser   : False
FirewallSqlServer : False

DATABASE FILES FOR:  [ SQL2019 ]
Sizes are shown in MB

MdfFile      : Eulanda_Doe.mdf
LdfFile      : Eulanda_Doe_log.ldf
MdfSize      : 6387,0625
LdfSize      : 565,4375
TotalSize    : 6952,5
LastModified : 2023-03-06 04:42:21

MdfFile      : Eulanda_John.mdf
LdfFile      : Eulanda_John_log.ldf
MdfSize      : 2692,75
LdfSize      : 0,4921875
TotalSize    : 2693,24
LastModified : 2023-03-06 04:37:31

Firewall rules was not to check, this requires administrator privileges. For this reason FirewallValid=False.
```

The result is stored in the `Instances` variable. In addition, the Show parameter displays the most important values on the screen.

## PARAMETERS

### -show
The function displays the most important data on the screen. Additionally it is displayed if the administrative rights are not sufficient to check the firewall rules.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
