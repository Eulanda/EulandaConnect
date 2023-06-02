---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DeliverySql.md
schema: 2.0.0
---

# Get-DeliverySql

## SYNOPSIS
Creates a SQL command to retrieve a delivery note incl. positions

## SYNTAX

```
Get-DeliverySql [[-deliveryId] <Int32>] [[-deliveryNo] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Generates two SQL commands that are returned as an array of strings. One is a query of a delivery note header and the other is a query of the corresponding positions. The delivery note is found via the ID or its delivery note number.

## EXAMPLES

### EXAMPLE 1:Creates an SQL query to retrieve a delivery bill including its attached line items
```powershell
[int]$deliveryNo = 430220
[string[]]$sql= Get-DeliverySql -deliveryNo $deliveryNo
[System.Object]$data = Get-DataFromSql -sql $sql -conn $script:conn
```

Creates a string array with two SQL queries and a link relationship, which is required in `Get-DataFromSql` if it is a set from Master / Detail. In the `Get-DataFromSql` function, a retrieval with the second SQL query is then performed for each delivery bill.

## PARAMETERS

### -deliveryId
The delivery note is searched for by its ID.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 0
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
Default value: 0
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
