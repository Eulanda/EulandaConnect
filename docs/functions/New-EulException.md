---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/New-EulException.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# New-EulException

## SYNOPSIS
Creates a custom exception object

## SYNTAX

```
New-EulException [[-message] <String>] [[-additionalData] <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a custom exception object with an additional parameter for an extended message.

## EXAMPLES

### Example 1:Simple scenario for an extended exception
```powershell
try {
	Throw [EulException]::new("This is my error with two parameters",  "My second parameter")
} catch [EulException] {
	Write-Host "ERROR Message: $_ More info: $($_.Exception.additionalData)" -ForegroundColor Red
	Exit 1
} catch {
	Write-Host "ERROR Message: $_" -ForegroundColor Red
}
```

Show how to get the extended error message from that class.

## PARAMETERS

### -additionalData
Additional data, which is passed to the exception.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -message
Message as for the standard exception.

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

## RELATED LINKS


