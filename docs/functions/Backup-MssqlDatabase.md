---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Backup-MssqlDatabase.md
schema: 2.0.0
---

# Backup-MssqlDatabase

## SYNOPSIS
This PowerShell function backs up a Microsoft SQL Server database to a file, compresses it, and stores it locally and/or on an FTP server. The local backup files also the FTP files are kept according to the specified history. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Backup-MssqlDatabase.ps1).

## SYNTAX

```
Backup-MssqlDatabase [[-server] <String>] [[-protocol] <String>] [[-port] <Int32>] [-activeMode]
 [[-resumeAge] <Int32>] [[-resumeRetries] <Int32>] [[-certificate] <String>] [[-user] <String>]
 [[-password] <Object>] [[-remoteFolder] <String>] [[-storageFolder] <String>] [-removeBak]
 [[-history] <Int32>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Backup-MssqlDatabase` script allows for easy backup of Microsoft SQL Server databases to a local file storage location or an FTP server. It utilizes ADO to connect to the SQL server and locates the backup folder using the Windows registry. The script must be executed on the computer where the SQL server is running. It can be easily integrated into the Windows Task Scheduler to perform automated backups without requiring a logged-in user.

The script defaults to retaining the latest three backups of the database and provides an option to delete the original `.bak` file created during the backup process via the `-removeBak` switch. This can be useful when storage space is limited, particularly for large databases. The number of backup generations to retain can be modified via the `-history` parameter.

When backing up a database to a file storage location or an FTP server, a subfolder with the name of the SQL instance is created to store the corresponding databases. This allows for other databases of the same instance to be backed up in the same location.

The script returns the name of the original ZIP file, which is also stored in the standard folder for SQL databases. This enables further operations to be performed on the created ZIP file after the backup. If the function result is not needed, the output can be piped to `Out-Null` to avoid unnecessary display of the ZIP file name.

The files stored in the file storage location or on the FTP server are named after the corresponding database, with a timestamp added. For example: `Eulanda_JohnDoe-2023-05-07-17-31-00-0765.zip`.

## EXAMPLES

### Example 1: Backup a SQL database to a local store and an FTP server
```powershell
PS C:\> Backup-MssqlDatabase -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -storageFolder '\\NAS1\store' -server 'myFtp.eulanda.eu' -user 'doe' -password 'superPass' -remoteFolder '/MyFiles'
```

This command backs up the database defined in the specified `.udl` file, compresses the backup file, and stores it in both the specified local folder  `-storageFolder` under `\\NAS1\store` and the specified FTP server. The command sorts the backup files by date and removes the oldest backup files, keeping only the specified number of recent backups, the default is 3.

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

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -connStr
A `ConnectionString` can be specified here, with which a database can be opened.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -history
Optional integer parameter. The number of backups to keep. Default value is 3.

```yaml
Type: Int32
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

### -removeBak
Optional switch parameter. If specified, the backup file created during the process is deleted from the database server after compression and storage.

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

### -storageFolder
This is an optional string parameter that represents the path to the local folder where the backup files should be stored. If this parameter is provided, a folder with the name of the SQL instance is added to the folder name specified by the parameter. If this parameter is not specified, the backup files are not stored locally.

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

### -udl
Alternatively to a connection, a string to a UDL file can be specified. In this case an ADO object is created and closed again at the end of the function.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
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

[Backup-MssqlDatabase.ps1 on GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Backup-MssqlDatabase.ps1)





