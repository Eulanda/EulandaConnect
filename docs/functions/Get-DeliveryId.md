---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DeliveryId.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-DeliveryId

## SYNOPSIS
Returns the `Id` for a delivery bill

## SYNTAX

```
Get-DeliveryId [[-deliveryNo] <Int32>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Based on a delivery bill number, the Id to a delivery bill is returned. The Id is used for various functions. Especially for linking tables. The database can be specified via a Connection object, a UDL file or a ConnectionString.

## EXAMPLES

### Example 1:Returns the Id of the specified delivery bill
```powershell
PS C:\> Get-DeliveryId -deliveryNo 20230515  -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

After executing the command, the function result returns the Id of the delivery bill to which the delivery note number `20230515` belongs. The database is accessed by specifying a UDL file. Instead, an existing Connection object could also be specified.

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
A ConnectionString can be specified here, with which a database can be opened.

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

### -deliveryNo
The delivery note is found via its delivery note number.

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


