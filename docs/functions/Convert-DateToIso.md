---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-DateToIso.md
schema: 2.0.0
---

# Convert-DateToIso

## SYNOPSIS
Converts a date to an ISO string

## SYNTAX

```
Convert-DateToIso [[-value] <DateTime>] [-asUtc] [-noTime] [-noDate] [-noTimeZone] [-zeroTime] [-noonTime]
 [<CommonParameters>]
```

## DESCRIPTION
This function has several options to convert a date-time value combination into a string.

## EXAMPLES

### Example 1:Local date in ISO format
```powershell
PS C:\> [string]$myDate= Convert-DateToIso -value $(Get-Date) -noTimeZone
PS C:\> $myDate
```

```
# Output

2023-02-17T13:29:02
```

`Convert-DateToIso` takes the current date with time via the value parameter and outputs the date value in the local time.

## PARAMETERS

### -asUtc
The date is output in UTC, i.e. Greenwitch time. Here only a Z is appended to the output. 

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

### -noDate
The date is suppressed or set to 1.1.1 for this output. However, only the time is output due to the formatting.

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

### -noTime
The time is suppressed for this output or set to 0:00. However, only the date is output due to the formatting.

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

### -noTimeZone
The date is output in local time without specifying the time zone.

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

### -noonTime
The time is ignored and set to 12 noon.

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

### -value
The value of the date/time combination to convert.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zeroTime
The time is ignored and set to 0:00.

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
