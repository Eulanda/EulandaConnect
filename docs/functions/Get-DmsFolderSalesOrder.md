---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DmsFolderSalesOrder.md
schema: 2.0.0
---

# Get-DmsFolderSalesOrder

## SYNOPSIS
Delivers the DMS folder to a sales order

## SYNTAX

```
Get-DmsFolderSalesOrder [[-salesOrderNo] <Int32>] [[-salesOrderId] <Int32>] [[-customerOrderNo] <Int32>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
There is a simple but flexible document management system (= **DMS**) for the ERP system. It is stored on a network-accessible share. For each data object such as articles, addresses, etc. there are subfolders and then for each address in turn the final DMS folder. The `$dmsBaseFolder` is the root of the DMS system. Sales orders are stored below the invoice address. 
This function then returns the appropriate folder for a given sales order. In this folder specific files to the sales order can be stored, for example technical drawings, contract agreements, etc.

## EXAMPLES

### Example 1:Returns the DMS folder of a sales order
```powershell
PS C:\> [string]$path= Get-DmsFolderSalesOrder -salesOrderNo 30221218  -dmsBaseFolder '\\server\release\eulanda\dms' -udl "C:\temp\Eulanda_1 JohnDoe.udl"
PS C:\> Write-Host $path
```

```ini
# Output
\\server\release\eulanda\dms\address\John Doe\Sales Order\30221218
```

After calling the function, the variable contains the path for the storage in the DMS system for the sales order with the number `30221218`. **John Doe** in this example would be the name (= field Match) of the invoice address. The access to the database is done via the UDL file which was passed as parameter. The DMS system can only be localized if the DMS base folder is specified.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerOrderNo
This is the customer's order number. It is typically passed from an external system, such as an online shop system, to the ERP (Enterprise Resource Planning) system as a unique reference. It should be noted that this value is not defined as unique in the ERP system's database itself.

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

### -salesOrderId
The `SalesOrderId` is the `ID` of the header record of the sales order. The `ID` is always unique throughout the table. Only one of the parameters can be specified, either -salesOrderId or -salesOrderNo.

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

### -salesOrderNo
The `SalesOrderNo` is the userfriendly `number` of the header record of the sales order. The `number` is always unique throughout the table. Only one of the parameters can be specified, either -salesOrderId or -salesOrderNo.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 5
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
