---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DeliveryStatus.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-DeliveryStatus

## SYNOPSIS
Returns the status of the delivery bill

## SYNTAX

```
Get-DeliveryStatus [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The status of the delivery bill indicates in which mode it is. The status is an integer value and can assume different values. The higher the number, the further the delivery bill is completed. A delivery bill is completed when the status value is >20.

## EXAMPLES

### Example 1:Returns the status of a delivery note
```powershell
PS C:\> [int]$status = Get-DeliveryStatus -deliveryNo 20230515  -udl "C:\temp\Eulanda_1 JohnDoe.udl"
```

Here the status of the delivery bill `20230515` is returned. Alternatively, its `Id` can also be specified. In this example, the database is accessed via an UDL file.

### Example 2:Table of Status code

```ini
┌───────┬───────────────────────┬──────────────────────┐
│ Value │ Description (English) │ Description (German) │
├───────┼───────────────────────┼──────────────────────┤
│ 0     │ Capture               │ Erfassen             │
│ 2     │ Captured              │ Erfasst              │
│ 5     │ Reserved              │ Reserviert           │
│ 6     │ Transfer to WMS       │ Übergeben an LVS     │
│ 8     │ Picking               │ Kommissioniermodus   │
│ 9     │ Shippable             │ Versandfertig        │
│ 10    │ Delivered             │ Geliefert            │
│ 20    │ Billed                │ Berechnet            │
│ 21    │ Underbilled           │ Unterberechnet       │
│ 22    │ Unbilled              │ Unberechnet          │
└───────┴───────────────────────┴──────────────────────┘
```

*Table of possible values and their meaning*

## PARAMETERS

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

### -deliveryId
The delivery note is searched for by its ID.

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

### -deliveryNo
The delivery note is found via its delivery note number.

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
Position: 3
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


