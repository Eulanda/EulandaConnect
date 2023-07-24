---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Merge-IpGeoInfo.md
schema: 2.0.0
---

# Merge-IpGeoInfo

## SYNOPSIS
`Merge-IpGeoInfo` is a function that merges two XML databases containing IP geographic information. It checks for duplicate IP entries and retains the one with the most recent `ChangeDate`. It helps consolidate and manage your data effectively, ensuring that the final, merged database is up-to-date.

## SYNTAX

```
Merge-IpGeoInfo [-xmlFile1] <String> [-xmlFile2] <String> [-outputFile] <String> [<CommonParameters>]
```

## DESCRIPTION
`Merge-IpGeoInfo` is a PowerShell function designed to merge multiple XML databases created by the `Get-IpGeoInfo` function. When `Get-IpGeoInfo` is used to fetch geographic information about IP addresses, it stores the data in XML format. If you've accumulated multiple XML databases over time, managing them might be complicated.

This function aims to solve that problem by merging two XML databases into one. The merging process checks for duplicate IP entries between the two databases. When a duplicate is found, the function compares the `ChangeDate` attribute of the IP entry. The IP information with the most recent `ChangeDate` is kept, ensuring that the final, merged database is up-to-date.

## EXAMPLES

### Example 1: Merges two xml databases with geo information into a new one
```powershell
PS C:\> Merge-IpGeoInfo -FilePath1 'Path\To\First\File.xml' -FilePath2 'Path\To\Second\File.xml' -OutputPath 'Path\To\Merged\File.xml'
```

This command merges the data in `File.xml` located at `Path\To\First\` and `File.xml` located at `Path\To\Second\`, then writes the resulting merged database to `File.xml` at `Path\To\Merged\`.

## PARAMETERS

### -outputFile
Specifies the path of the output file. The cmdlet will create this file, containing the merged IP geolocation information.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -xmlFile1
Specifies the path of the first XML file. This file must exist on the disk.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -xmlFile2
Specifies the path of the second XML file. This file must exist on the disk.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

This function is part of a suite of tools designed to manage IP geographic information. Always make sure to have backups of your data and to test the function in a safe environment before deploying it to production.

## RELATED LINKS

[Get-IpGeoInfo](../functions/Get-IpGeoInfo.md)
