---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Confirm-System.md
schema: 2.0.0
---

# Confirm-System

## SYNOPSIS
This PowerShell function retrieves various system information to quickly diagnose a malfunction. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Confirm-System.ps1).

## SYNTAX

```
Confirm-System [-all] [-administrator] [-controlledFolderAccess] [-memory] [-drives] [-network]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function retrieves various values from the computer system to quickly diagnose a malfunction. The results are collected in an array of PsCustomObject, which can be piped to Out-GridView or Format-Table for further processing.

Different switches can be used to determine which check sets should be retrieved.

## EXAMPLES

### Example 1:Possible results for system diagnosis.
```powershell
PS C:\> $result = Confirm-System -administrator -controlledFolderAccess -memory -drives -network
PS C:\> $result | Format-Table
```

```
Description                                  Value
-----------                                  -----
Administrative rights                        False
Ransomware protection aktiv                  False
Working memory (GB)                          32
Drive free on C (GB)                         445
Drive free on D (GB)                         427
Drive free on F (GB)                         17
S.M.A.R.T. (USB  SanDisk 3.2Gen1 USB Device) OK
S.M.A.R.T. (Samsung SSD 870 QVO 2TB)         OK
S.M.A.R.T. (NVMe Samsung SSD 970)            OK
Gateway Ip                                   192.168.178.1
Gateway Name                                 fritz.box
Local Ip                                     192.168.178.10
Local Subnet                                 255.255.255.0
Local CIDR                                   24
Public Ip                                    98.32.56.11
Max possible Hosts                           254
Network ID                                   192.168.178.0
First possible Ip                            192.168.178.1
Last possible Ip                             192.168.178.254
Broadcast Ip                                 192.168.178.255
```

The output of this function shows some of the possible results for system diagnosis.

## PARAMETERS

### -administrator
Checks if the user has administrative rights.

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

### -all
All optiones are used.

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

### -controlledFolderAccess
This function checks if the Microsoft ransomware protection for monitored folders is active. This protection prevents, for example, the creation of folders in 'My Documents' in the command prompt. Similarly, PowerShell modules cannot be installed as the current user, only as an administrator for all users.

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

### -drives
This function retrieves the list of installed drives and checks the health status of the disks. The function retrieves the installed drives using `Get-PSDrive` and filters the file system drives. It then loops through the drives, checks the physical disks using `Get-PhysicalDisk`, and filters the HDD and SSD disks that have an operational status of OK or Healthy. 

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

### -memory
Checks how much memory is installed.

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

### -network
This function checks the network settings and tests name resolution. It pings the default gateway and then performs a DNS lookup of the local host name and compares the results. If they match, it checks if the DNS server is reachable. The output is a `PsCustomObject` that can be piped to `Out-GridView` or `Format-Table`.

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

[Confirm-System.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Confirm-System.ps1)




