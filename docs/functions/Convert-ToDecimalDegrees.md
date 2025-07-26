---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-ToDecimalDegrees.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Convert-ToDecimalDegrees

## SYNOPSIS
This PowerShell function converts coordinates in Degrees-Minutes-Seconds (DMS) format to Decimal Degrees (DD). Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-ToDecimalDegrees.ps1).

## SYNTAX

```
Convert-ToDecimalDegrees [[-degrees] <Int32>] [[-minutes] <Int32>] [[-seconds] <Int32>] [[-direction] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function takes coordinates in Degrees-Minutes-Seconds (DMS) format, along with a direction (N,S,E,W), and converts them to Decimal Degrees (DD) format. For southern latitudes and western longitudes, the DD value will be negative. Make sure that the values you input are valid DMS coordinates

## EXAMPLES

### Example 1: Converts coordinates to Decimal Degrees
```powershell
PS C:\> Seconds of the DMS coordinate. Should be an integer between 0 and 59.
```

Returns: 52.52

## PARAMETERS

### -degrees
Degrees of the DMS coordinate. Should be an integer between 0 and 180.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -direction
The direction of the DMS coordinate. Should be one of 'N', 'S', 'E', 'W' (case insensitive).

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: N, S, E, W

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -minutes
Minutes of the DMS coordinate. Should be an integer between 0 and 59.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -seconds
Seconds of the DMS coordinate. Should be an integer between 0 and 59.

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

[Get-Distance](../functions/Get-Distance.md)






