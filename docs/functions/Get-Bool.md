---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-Bool.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-Bool

## SYNOPSIS
This PowerShell function converts a string like 0, 1 Ture or False to a Boolean. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-Bool.ps1).

## SYNTAX

```
Get-Bool [[-boolStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function converts a text to a boolean, where '1' and 'True' result in the value $true and all other values result in the value $false.  

## EXAMPLES

### Example 1:Converts  string '1' to $true
```powershell
PS C:\> Get-Bool -boolStr '1'
```

```ini
# Output

True
```

In this example the string with content `1` is passed to the function Get-Bool. This causes the function to return `True`.

## PARAMETERS

### -boolStr
Is the string value to be converted.

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


