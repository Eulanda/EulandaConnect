---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Send-RemoteFile.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Send-RemoteFile

## SYNOPSIS
The Send-RemoteFile function allows uploading a file to a remote server using FTP, FTPS (explicit), or SFTP.

## SYNTAX

```
Send-RemoteFile [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-resumeAge] <Int32>] [[-resumeRetries] <Int32>] [[-certificate] <String>] [[-user] <String>]
 [[-password] <Object>] [[-remoteFolder] <String>] [[-remoteFile] <String>] [[-localFolder] <String>]
 [[-localFile] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Send-RemoteFile function allows uploading a file to a remote server using FTP, FTPS (explicit), or SFTP. It supports authentication with a username and password, where the password can be provided as clear text or as a SecureString. For SFTP transfers, it also supports using a certificate. In addition, FTP and FTPS support resuming an interrupted upload. The Send-RemoteFile function provides a convenient way to upload files to a remote server using various protocols.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Uploads a file by ftp protocol on a remote server using simple authentication
```powershell
PS C:\> Send-RemoteFile -server "ftp.example.com" -protocol "ftp" -user "username" -password "password" -localFolder 'C:\temp' -localFile 'test.txt' -remoteFolder '/EULANDA' -remoteFile 'others.txt'
```

This example demonstrates how to upload a file to an FTP server using the specified username and password.

## PARAMETERS

### -activeMode
If specified, this switch enables active mode for the FTP or FTPS connection. By default, passive mode is used.

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

### -certificate
The path to a certificate file for authentication, if using SFTP with certificate-based authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -localFile
The local file that is to be uploaded to the remote server via FTP, FTPS, or SFTP.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -localFolder
The local folder where the file to be uploaded is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
The password to use for authentication with the remote server. This can be provided as plaintext or as a SecureString.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -port
The port number to connect to on the remote server. This typically defaults to 21 for FTP and FTPS, or 22 for SFTP if not specified.

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

### -protocol
The protocol to use for the connection, such as FTP, FTPS, or SFTP.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ftp, ftps, sftp

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remoteFile
The filename that the file should be named as when uploaded to the remote server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remoteFolder
Directory on the remote server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resumeAge
The maximum age of a file in seconds whose upload was interrupted.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resumeRetries
The number of attempts made to upload a file that was interrupted during the upload process.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -server
The address or hostname of the remote server to connect to.

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

### -user
The username to use for authentication with the remote server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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


