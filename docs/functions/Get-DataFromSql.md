---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DataFromSql.md
schema: 2.0.0
---

# Get-DataFromSql

## SYNOPSIS
This PowerShell function creates a data structure based on an SQL select command. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-DataFromSql.ps1).

## SYNTAX

```
Get-DataFromSql [[-sql] <String[]>] [[-arrRoot] <String>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The function creates a PowerShell data structure as a result that returns a hash table, an array of hash tables, or a combination of these. It expects the SQL query as an array of strings, from various select commands. The array must contain at least one SQL command. If two SQL commands are specified, the first is processed as master and the second as detail.

The connection to a database is made either via an existing connection, the specification of a UDL file name or the specification of a connection string.

## EXAMPLES

### EXAMPLE 1:Exporting a delivery note to a data object
```powershell
[int]$deliveryNo = 430220
[string[]]$sql= Get-DeliverySql -deliveryNo $deliveryNo
[System.Object]$data = Get-DataFromSql -sql $sql -conn $conn
```

In this example, the delivery bill with the number `430220` is exported to a nested hash table. The appropriate SQL commands to generate a master/detail connection are provided by the `Get-DeliberySql` function. This data could then be output as an XML file, for example.

## PARAMETERS

### -arrRoot
Specifying the parameter allows to specify the node name of the detail in case of a master-detail relationship. The term should be specified in plural.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Items
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -connStr
A ConnectionString can be specified here, with which a database can be opened.

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

### -sql
The SQL parameter can contain several sections, each of which is an independently executable SQL query. For this reason, the parameter is an array of strings. If only a single array element is specified, it is usually several records, i.e. a list.

If two queries are specified, the first is considered the master and may return only one record. The second SQL query is then the detail query. For an invoice, for example, this would be the invoice items.

If a third array element is specified, it is the summary, i.e. the totals that are to be shown in a report.

```yaml
Type: String[]
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
