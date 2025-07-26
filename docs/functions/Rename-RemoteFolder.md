---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Rename-RemoteFolder.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Rename-RemoteFolder

## SYNOPSIS
The `Rename-RemoteFolder` cmdlet is used to rename a folder on a remote server using various protocols such as FTP, FTPS, or SFTP.

## SYNTAX

```
Rename-RemoteFolder [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-certificate] <String>] [[-user] <String>] [[-password] <Object>] [[-remoteFolder] <String>]
 [[-newFolder] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Rename-RemoteFolder` cmdlet allows you to rename a folder on a remote server. You can specify the server address or hostname, the protocol to use (such as FTP, FTPS, or SFTP), the port number, and the necessary authentication details (username and password). By default, passive mode is used for FTP or FTPS connections, but you can enable active mode using the `-activeMode` switch. If you are using SFTP with certificate-based authentication, you can provide the path to a certificate file using the `-certificate` parameter.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Rename a remote folder with basic authentication
```powershell
PS C:\> Rename-RemoteFolder -server "ftp.example.com" -protocol "ftps" -port 21 -user "username" -password "password" -remoteFolder "/old_folder" -newFolder "/new_folder"
```

This example renames the folder named `/old_folder` to `new_folder` on the remote server "ftp.example.com" using FTPS (FTP over SSL) on port 21. The command uses for the username and password for authentication.

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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -newFolder
The new name for the remote folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
Position: 5
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

### -remoteFolder
Is the folder on the remote server that should be renamed.

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
Position: 4
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


