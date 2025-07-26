---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-OpenVpnTls.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-OpenVpnTls

## SYNOPSIS
Generates an OpenVPN TLS key in a specified directory.

## SYNTAX

```
New-OpenVpnTls [[-openVpnPath] <String>] [[-destination] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `New-OpenVpnTls` function generates an OpenVPN TLS key and places it in a specified directory. If the key already exists, it won't overwrite the existing key.  This function is designed to work with both older (prior to version 2.5, installed via .exe files) and newer versions of OpenVPN (version 2.5 and later, installed via MSI files).  It is part of a larger suite of functions aimed at automating the installation and configuration of OpenVPN in various environments. 

## EXAMPLES

### Example 1: Generate an OpenVPN TLS Key
```powershell
PS C:\> New-OpenVpnTls -openVpnPath "C:\Program Files\OpenVPN" -destination "$home\.eulandaconnect\OpenVPN"
```

```
# TLS CERT ta.key

#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
b1b4a3d27648df4e4a9ad20538c67a02
a59a771c7761957fdf3c0250da48f9a8
9f8b9d822420add3e10c6149d8ed733b
bbf801b2ccdf7d736ff4c13c817c304c
a5837de2273e0604ebb60abf11d2c526
8377290b5e7b977f6b999aa6a9b285e9
dfd535c721d91f8c39c9dfa97cef002e
5c37986949bdaea71196b2a57529f4e3
3de0e7298b27c268682bf6064319d20f
dea5830de593c20f417bda40ca46fe59
b08dca8e1291865d1833684318785135
76bf5190d3fb5addc7d768e8d72f1ed1
2b3eb3ef0479408cd275507b40de7e32
07dd00d605b010c935f157db6dfc27ab
1a5ce8b81400b0d1abc57d81c25119c1
9ac8a13309d6b62f2173bbabaf7b2a28
-----END OpenVPN Static key V1-----
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


