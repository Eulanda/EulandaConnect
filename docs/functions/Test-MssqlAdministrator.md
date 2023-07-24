---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Test-MssqlAdministrator.md
schema: 2.0.0
---

# Test-MssqlAdministrator

## SYNOPSIS
Checks if the current user in the database has the sysadmin role.

## SYNTAX

```
Test-MssqlAdministrator [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Test-MssqlAdministrator function checks whether the current user in the specified SQL Server database has the sysadmin role. It can be used to determine whether or not the user has administrative privileges in the database.

## EXAMPLES

### Example 1: Tests if the user specified in udl is in the sysadmin role
```powershell
PS C:\> Test-MssqlAdministrator -udl '.\source\tests\Eulanda_1 Pester.udl'
```

This example checks if the current user has the sysadmin role in the database configured in the UDL file '.\source\tests\Eulanda_1 Pester.udl'. If the user is sysadmin, the result will return "True", otherwise "False".

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

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

### -connStr
A `ConnectionString` can be specified here, with which a database can be opened.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 1
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
