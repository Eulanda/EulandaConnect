---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Rename-RemoteFile.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Rename-RemoteFile

## SYNOPSIS
Renames or moves a file on a remote server using the specified FTP, FTPS or SFTP protocol.

## SYNTAX

```
Rename-RemoteFile [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-certificate] <String>] [[-user] <String>] [[-password] <Object>] [[-remoteFolder] <String>]
 [[-remoteFile] <String>] [[-newFolder] <String>] [[-newFile] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This function uses the specified protocol (FTP, FTPS or SFTP) to connect to a remote server and perform a rename or move operation on a specified file. The original location and name of the file are specified by the `remoteFolder` and `remoteFile` parameters.

If `newRemoteFolder` is specified, the file will be moved to this folder. If `newRemoteFile` is also specified, the file will be renamed to this name in the new folder. If `newRemoteFolder` is not specified, but `newRemoteFile` is, the file will be renamed in its current folder.

Credentials to access the server are provided via the `user` and `password` parameters. The `protocol` parameter determines whether FTP, FTPS or SFTP is used for the operation, with the default being FTP.

The `activeMode` switch can be used to enable FTP active mode instead of the default passive mode. If using SFTP and the server requires a certificate for authentication, the `certificate` parameter can be used to provide the path to the certificate file.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Moves and renames a file on ftp server
```powershell
PS C:\> Rename-RemoteFile -server "ftp.example.com" -protocol "ftp" -user "user" -password "password" -remoteFolder "/path/to/old/folder" -remoteFile "oldfile.txt" -newRemoteFolder "/path/to/new/folder" -newRemoteFile "newfile.txt"
```

This example renames and moves the file "oldfile.txt" from "/path/to/old/folder" to "/path/to/new/folder" and renames it to "newfile.txt" on the FTP server "ftp.example.com" using the provided username and password.

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

### -newFile
The new name for the remote file. If no filename is specified, the existing file is simply moved to the new location specified in `newFolder`.

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

### -newFolder
If the `newFolder` is specified, the file given by `newFile` will be moved into this folder. If the folder is not specified, the file in the old folder will simply be renamed.

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

### -remoteFile
The remote file that is to be renamed.

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

### -remoteFolder
Is the folder on the remote server where the file to be renamed is located.

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


