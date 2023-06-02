---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Set-TrackingNo.md
schema: 2.0.0
---

# Set-TrackingNo

## SYNOPSIS
Adds further tracking numbers to the delivery bill

## SYNTAX

```
Set-TrackingNo [[-trackingNo] <Array>] [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-conn] <Object>]
 [[-udl] <String>] [[-connStr] <String>] [<CommonParameters>]
```

## DESCRIPTION
The tracking numbers specified in the trackingNo array are stored in the delivery bill. 
If tracking numbers were already present, they will be added. Duplicate tracking numbers are removed and the tracking numbers are sorted in descending order.
The number of shipments is automatically supplemented by added tracking numbers and the shipping date is set to the current date.

## EXAMPLES

### Example 1:Add two tracking numbers to a delivery note
```powershell
PS C:\> $trackingNo = @('1Z456655626','1Z94336654')
PS C:\> Set-TrackingNo -trackingNo $trackingNo -deliveryNo 430220 -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

In this example, two tracking numbers are added to delivery bill `430220`. The SQL database is specified via a UDL file.

## PARAMETERS

### -conn
The connection can be established via an existing ADO object of the type 'ADODB.Connection'. If the connection is already open, it remains open even after the function has been executed. If it was closed, it will be closed again after the function has been executed.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deliveryId
The delivery note is searched for by its ID.

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

### -deliveryNo
The delivery note is found via its delivery note number.

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

### -trackingNo
The tracking numbers are passed in an array. Each individual tracking number is of type string.

```yaml
Type: Array
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
