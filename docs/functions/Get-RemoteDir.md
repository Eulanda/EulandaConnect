---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-RemoteDir.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-RemoteDir

## SYNOPSIS
Retrieves a list of files or directories from an FTP or SFTP server.

## SYNTAX

```
Get-RemoteDir [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-certificate] <String>] [[-user] <String>] [[-password] <Object>] [[-dirType] <String>] [[-mask] <String>]
 [[-remoteFolder] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Get-RemoteDir` function is a versatile tool for retrieving a list of files or directories from a remote server. This function supports the FTP, FTPS, and SFTP protocols, allowing a wide range of remote servers to be accessed.

Authentication can be performed using ausername and password, which is commonly used for FTP/FTPS servers. For SFTP servers, a client certificate can be used for a more secure authentication method.

In addition, the function includes features to adjust the behavior of the request. For instance, the `-activeMode` switch allows FTP connections to use active mode instead of the default passive mode.

Furthermore, the `-mask` parameter allows to filter the results based on a specific file mask. This can be particularly useful when you're looking for files of a specific type or with a specific pattern in their name.

Whether you need to list all text files in a directory, find all directories in a certain path, or simply list all files in a directory, `Get-RemoteDir` provides a simple and efficient way to do it.

> Please note the **requirements** and **information** about FTP, FTPS, and SFTP, as well as SecureString, which we have summarized under [Sftp](../appendix/Sftp.md). There you will also find examples for creating a compatible certificate.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-RemoteDir -server 'ftp.example.com' -user 'username' -password 'password' -dirType 'file' -mask '*.txt'
```

This example retrieves a list of all .txt files from the root directory of the FTP server at ftp.example.com.

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

### -dirType
The type of directory to retrieve. Valid values are "file" and "directory". Default is "file".

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: file, directory

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mask
A file mask to filter the results. For example, '*.txt' will only return .txt files.

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
he remote folder to retrieve the list from. Default is the root directory.

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


