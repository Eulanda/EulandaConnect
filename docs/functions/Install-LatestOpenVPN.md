---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Install-LatestOpenVPN.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Install-LatestOpenVPN

## SYNOPSIS
Downloads and installs the latest version of OpenVPN.

## SYNTAX

```
Install-LatestOpenVPN [[-downloadPath] <String>] [-install] [-full] [[-openVpnMsi] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function downloads and installs the latest version of OpenVPN. If the `-install` switch is specified, it checks if OpenVPN is already installed. If it is, a warning is displayed and the installation is skipped. If the `-openVpnMsi` parameter is specified, it installs OpenVPN using the provided MSI file instead of downloading a new one. The function also supports an optional `-full` switch, which installs additional components required for certificate creation on servers. When downloading the client from the community website, the latest client for Windows 64 bit AMD systems is always used.

## EXAMPLES

### Example 1
```powershell
PS C:\> Install-LatestOpenVPN -install
```

Downloads and installs the latest version of OpenVPN.

## PARAMETERS

### -downloadPath
The path where the OpenVPN MSI file will be downloaded. The default location is the user's Downloads folder.

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

### -full
If specified, additional components required for certificate creation on servers will be installed along with OpenVPN.

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

### -install
If specified, the function will attempt to install OpenVPN. If OpenVPN is already installed, a warning will be displayed, and the installation will be skipped.

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

### -openVpnMsi
The path to a pre-downloaded OpenVPN MSI file. If specified, the function will install OpenVPN using the provided MSI file instead of downloading a new one.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


