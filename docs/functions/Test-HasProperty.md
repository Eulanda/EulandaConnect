---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-HasProperty.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Test-HasProperty

## SYNOPSIS
Tests if an object has a certain property

## SYNTAX

```
Test-HasProperty [[-inputVar] <Object>] [[-propertyName] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This can be used to test whether an object has a certain property.

## EXAMPLES

### Example 1: Test if the Error object has the `ScriptLineNumber` property
```powershell
try {
	$a= 5
	$b= 0
	$c = $a / $b
} catch {
	if (Test-HasProperty -inputVar $_.InvocationInfo -propertyName "ScriptLineNumber") {
		$line = $_.InvocationInfo.ScriptLineNumber
	} else {
		$line = 'unknown'
	}
	Write-Host "ERROR at Line: $line. Message: $_" -ForegroundColor Red
}
```

The error object does not have the `ScriptLineNumber` property in every case. With `Test-HasProperty`, for example, it can be checked whether the property exists and whether it can be used.

## PARAMETERS

### -inputVar
Object to check.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -propertyName
Property to check.

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


