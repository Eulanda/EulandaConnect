---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-RemoteFingerprint.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Remove-RemoteFingerprint

## SYNOPSIS
Remove the remote fingerprint from the local cache.

## SYNTAX

```
Remove-RemoteFingerprint [[-server] <String>] [[-protocol] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This function helps in managing the fingerprint data of remote servers that have been cached locally. It is particularly useful in scenarios where the remote server's fingerprint has changed due to reasons such as re-installation, updates, or any other modifications. The function removes the stored fingerprint data of the specified remote server from the local cache, allowing the updated fingerprint data to be reacquired in the next connection attempt.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Removes the fingerprint from local cache
```powershell
PS C:\> Remove-RemoteFingerprint -server "example.com"
```

This command removes the SFTP fingerprint of the server `example.com` from the local cache.

## PARAMETERS

### -protocol
Specifies the protocol of the remote server whose fingerprint needs to be removed. Currently, only the SFTP protocol is supported, which is also the default if no protocol is specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: sftp

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -server
Specifies the hostname or IP address of the remote server whose fingerprint needs to be removed.

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


