---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Protect-String.md
schema: 2.0.0
---

# Protect-String

## SYNOPSIS
Encrypts a text using a key

## SYNTAX

```
Protect-String [[-plainText] <String>] [[-key] <Object>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The function is passed a text to encrypt via the `plainText` parameter. The string specified in the key parameter must be either 32 or 16 characters long. Intermediate sizes are padded, but reduce security. If a key is passed that is longer than 32 characters, an exception is thrown. The counterpart to the function is `Unprotect-String`.

The key must be identical for encryption and decryption.

## EXAMPLES

### Example 1:Encrypts a text using a key
```powershell
PS C:\> [string]$protected= Protect-String -plainText 'I am unsecure' -key 'x&=Ogbu7$43lkn4i'
```

```ini
# Output

76492d1116743f0423413b16050a5345MgB8AC8ATABrAGwAQgA3AFAARABOAEYAQwArAEIATABwAGEAagBGAFUAQQBUAHcAPQA9AHwAMAAyADEAZABhAGQAMQA1ADQAZgBiADQAZABiADMAOQA4AGMANQA1ADIANQA4ADIANgAyAGMAYgBmAGUANQBjAGEAMgAxADMAMAA3ADQAZQAyAGMAYQA0ADAAMgBjAGYAZQA3ADMAMgAyADgANQAwADcANwA3ADQANABmADEANgA=
```

The text `I am unsecure` is encrypted using the key `x&=Ogbu7$43lkn4i` and stored in the variable `$protected`.

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

### -plainText
The free text to be encrypted.

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

[Unprotect-String](./functions/Unprotect-String.md)



