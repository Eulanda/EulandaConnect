---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Unprotect-String.md
schema: 2.0.0
---

# Unprotect-String

## SYNOPSIS
Decrypts a text using a key

## SYNTAX

```
Unprotect-String [[-protectedText] <Object>] [[-key] <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function is passed an encrypted text via the `protectedText` parameter. This was previously encrypted with `Protect-String`. The `key` parameter must be either 32 or 16 characters long. Intermediate sizes are padded, but reduce security. If a key longer than 32 characters is passed, an exception is thrown. The counterpart to this function is `protect-string`.

The key must be identical for encryption and decryption.

## EXAMPLES

### Example 1:Entschlüsseln des Textes
```powershell
PS C:\> [string]$protected= '76492d1116743f0423413b16050a5345MgB8AC8ATABrAGwAQgA3AFAARABOAEYAQwArAEIATABwAGEAagBGAFUAQQBUAHcAPQA9AHwAMAAyADEAZABhAGQAMQA1ADQAZgBiADQAZABiADMAOQA4AGMANQA1ADIANQA4ADIANgAyAGMAYgBmAGUANQBjAGEAMgAxADMAMAA3ADQAZQAyAGMAYQA0ADAAMgBjAGYAZQA3ADMAMgAyADgANQAwADcANwA3ADQANABmADEANgA='
PS C:\> [string]$plain= Unprotect-String -protectedText $protected -key 'x&=Ogbu7$43lkn4i'
```

```ini
# Output

I am unsecure
```

The encrypted text is passed to the function with the original key and decrypted. The result is then `I am unsecure`, i.e. the value originally passed with `Protect-String`.

## PARAMETERS

### -key
The key that is used for encryption. It should contain either 16 or 32 characters. An exception is thrown for larger values.

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

### -protectedText
The encrypted text to be decrypted.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Protect-String](./functions/Protect-String.md)



