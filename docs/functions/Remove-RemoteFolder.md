---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Remove-RemoteFolder.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Remove-RemoteFolder

## SYNOPSIS
Removes a specified folder from a remote server, supporting FTP, FTPS, and SFTP protocols.

## SYNTAX

```
Remove-RemoteFolder [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-certificate] <String>] [[-user] <String>] [[-password] <Object>] [[-remoteFolder] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Remove-RemoteFolder` function is a versatile tool for deleting a specified directory from a remote server. It supports FTP, FTPS, and SFTP protocols, making it adaptable to various server configurations.

The function uses basic authentication (username and password) for server access. When working with SFTP, there's an option for certificate-based authentication. The `-activeMode` switch is available for servers that require active mode FTP.

To utilize this function, specify the server's address, the protocol (FTP, FTPS, or SFTP), the port number, the desired mode (active or passive, with passive as the default), the path to the SSH private key (if using SFTP), your username and password, and the path of the directory you wish to remove from the server.

Ensure the directory specified for deletion is empty, as the function might not execute successfully otherwise.

This function provides no return output if the operation is successful and throws an exception if an error occurs.

The function's usability is subject to the server's policy, network conditions, and the necessary permissions to perform the deletion operation on the target server.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1: Removing a directory on an SFTP server using basic authentication credentials
```powershell
PS C:\> Remove-RemoteFile -server "ftp.example.com" -protocol "sftp" -user "username" -password "password" -remoteFolder "/docs"
```

This example demonstrates the process of deleting the "/docs" directory from the SFTP server located at "ftp.example.com". It involves a function that utilizes the given username and password for authentication purposes. It's crucial to note that in order for the command to be executed successfully, the target directory must be devoid of any files or subdirectories; it must be empty.

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
The path to the folder on the remote server.

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


