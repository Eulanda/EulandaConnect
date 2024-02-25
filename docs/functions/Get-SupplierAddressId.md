---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-SupplierAddressId.md
schema: 2.0.0
---

# Get-SupplierAddressId

## SYNOPSIS
The `Get-SupplierAddressId` function retrieves the latest revision of a supplier's address from a SQL database. 

## SYNTAX

```
Get-SupplierAddressId [[-supplierID] <Int32>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The function executes a SQL query that selects the address revision with the highest revision number for each supplier address, effectively fetching the latest revision of the address.

If the SQL query returns a non-empty result, the function extracts the ID of the address with the highest revision number.

In summary, `Get-SupplierAddressId` provides a way to retrieve the latest revision of a supplier's address in a SQL database, taking into account a complex table structure and ensuring that all database interactions are secure and robust. It's designed to be flexible and easy to use, with various options for specifying the database connection.

## EXAMPLES

### Example 1
```powershell
PS C:\> $id = Get-SupplierAddressId -supplierID 15 -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

Returns the SupplierAdressId with the highest revision of address information.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

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

### -connStr
A `ConnectionString` can be specified here, with which a database can be opened.

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

### -supplierID
This mandatory integer parameter is used to specify the ID of the supplier for which you want to retrieve the latest address revision.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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
Position: 2
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

