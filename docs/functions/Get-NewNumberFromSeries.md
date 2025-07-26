---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-NewNumberFromSeries.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-NewNumberFromSeries

## SYNOPSIS
Generates a new number for a specific series.

## SYNTAX

```
Get-NewNumberFromSeries [[-seriesName] <String>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Get-NewNumberFromSeries` function generates a new number for a specific series in a database using an ADODB connection. The function uses the "cn_NumGetNext" stored procedure and executes it with the series name to get the next available number.

The function takes the series name as a parameter, and it is expected to be one of the following:

| Series Name (German) | Series Name (English) |
|---|---|
| Angebot | Offer |
| Auftrag | Order |
| Rechnung | Invoice |
| Lieferschein | Delivery Note |
| Debitor | Debtor |
| KasseBeleg | Cash Receipt |
| KrAuftrag | Wholesale Order |
| Inventurbelege | Inventory Documents |
| EDIListen | EDI Lists |
| Umbuchungen | Transfers |
| Warenbewegungen | Goods Movements |
| Wareneingaenge | Goods Receipts |

## EXAMPLES

### Example 1: Next Number of series name 'KrAuftrag'
```powershell
PS C:\> $i = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -udl 'C:\temp\EULANDA_1 JohnDow.udl'
```

In this example, a new number for the 'KrAuftrag' (Wholesale Order) series is generated using a UDL file to establish the ADODB connection.

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

### -seriesName
Specifies the name of the series for which a new number is to be generated. The value must be one of the series listed in the description.

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

Please ensure that the necessary resources such as the "cn_NumGetNext" stored procedure and ADODB connection are available and configured correctly.

## RELATED LINKS


