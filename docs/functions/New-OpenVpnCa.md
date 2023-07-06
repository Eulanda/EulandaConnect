---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-OpenVpnCa.md
schema: 2.0.0
---

# New-OpenVpnCa

## SYNOPSIS
Generates a new OpenVPN certificate authority (CA) for server certificates.

## SYNTAX

```
New-OpenVpnCa [[-openVpnPath] <String>] [[-destination] <String>] [[-hostname] <String>] [[-country] <String>]
 [[-province] <String>] [[-city] <String>] [[-organisation] <String>] [[-unit] <String>]
 [[-passphrase] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function generates a new OpenVPN certificate authority (CA) for server certificates. It uses OpenSSL to generate the CA key and certificate files. The generated files are stored in the specified destination folder. The function accepts various parameters to customize the CA generation process, such as country, province, city, organization, and unit. 

## EXAMPLES

### Example 1: Generates a new certificate authority
```powershell
PS C:\> New-OpenVpnCa
```

Generates a new OpenVPN certificate authority (CA) using default settings.

## PARAMETERS

### -city
The city for the certificate authority. The default value is "Huenstetten".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
The country code for the certificate authority. The default value is "DE" (Germany).

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

### -destination
The destination folder where the generated CA key and certificate files will be stored. The default location is "$($home)\.eulandaconnect\OpenVPN".

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
The hostname used to identify the certificate authority. By default, it retrieves the hostname from the system using [System.Net.Dns]::GetHostname().

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

### -openVpnPath
The path to the OpenVPN installation directory. The default path is "$($env:ProgramFiles)\OpenVPN".

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

### -organisation
The organization name for the certificate authority. The default value is "EULANDA".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -passphrase
The passphrase used to protect the CA key file. The default value is "bond".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -province
The province or state for the certificate authority. The default value is "HE" (Hesse).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -unit
The organizational unit for the certificate authority. The default value is "eCommerce".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
