---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-OpenVpnTls.md
schema: 2.0.0
---

# New-OpenVpnTls

## SYNOPSIS
Generates an OpenVPN TLS key in a specified directory.

## SYNTAX

```
New-OpenVpnTls [[-openVpnPath] <String>] [[-destination] <String>] [<CommonParameters>]
```

## DESCRIPTION
The `New-OpenVpnTls` function generates an OpenVPN TLS key and places it in a specified directory. If the key already exists, it won't overwrite the existing key.  This function is designed to work with both older (prior to version 2.5, installed via .exe files) and newer versions of OpenVPN (version 2.5 and later, installed via MSI files).  It is part of a larger suite of functions aimed at automating the installation and configuration of OpenVPN in various environments. 

## EXAMPLES

### Example 1: Generate an OpenVPN TLS Key
```powershell
PS C:\> New-OpenVpnTls -openVpnPath "C:\Program Files\OpenVPN" -destination "C:\Users\john\.eulandaconnect\OpenVPN"
```

In this example, an OpenVPN TLS key is generated using the OpenVPN installation at "C:\Program Files\OpenVPN" and is placed in the directory `C:\Users\user.eulandaconnect\OpenVPN`.

## PARAMETERS

### -destination
The destination directory where the OpenVPN TLS key will be placed.

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

### -openVpnPath
The path to the OpenVPN installation directory. 

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

Make sure that the OpenVPN installation directory and the destination directory are correctly specified. If the key already exists in the destination directory, this function will not overwrite the existing key.

## RELATED LINKS
