---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Distance.md
schema: 2.0.0
---

# Get-Distance

## SYNOPSIS
Calculates the distance between two points on the Earth's surface, given their coordinates in Decimal Degrees (DD).

## SYNTAX

```
Get-Distance [[-startLatitude] <Double>] [[-startLongitude] <Double>] [[-endLatitude] <Double>]
 [[-endLongitude] <Double>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function takes the coordinates of two points on the Earth's surface in Decimal Degrees (DD) format, and calculates the distance between these points in kilometers using the Haversine formula. Make sure that the coordinates you input are valid Decimal Degrees.

## EXAMPLES

### Example 1: Calculates the distance between two points
```powershell
PS C:\> Get-Distance -startLatitude  52.52 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522
```

The example uses the geographic coordinates of two major European cities: Berlin, Germany and Paris, France. The coordinates `52.52` for latitude and `13.405` for longitude represent the approximate location of Berlin. On the other hand, `48.8566` for latitude and `2.3522` for longitude represent the approximate location of Paris. The result is 878 km.

## PARAMETERS

### -endLatitude
Latitude of the second point in DD format. Should be a decimal number between -90 and 90.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: lat2

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endLongitude
Longitude of the second point in DD format. Should be a decimal number between -180 and 180.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: long2

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startLatitude
Latitude of the first point in DD format. Should be a decimal number between -90 and 90.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: lat1

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startLongitude
Longitude of the first point in DD format. Should be a decimal number between -180 and 180.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: long1

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

[Convert-ToDecimalDegrees](../functions/Convert-ToDecimalDegrees.md)





