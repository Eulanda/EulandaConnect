---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-StockSql.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-StockSql

## SYNOPSIS
Creates a SQL command to retrieve stock informations

## SYNTAX

```
Get-StockSql [[-filter] <String[]>] [[-alias] <String>] [[-qtyStatic] <Int32>] [[-warehouse] <String>]
 [-legacy] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates an array of strings. The first array element contains the SQL query for the master dataset, second the SQL query contains the query for the detail query and third array element contains the field that creates the link between the queries. The details are dynamically bound to the respective master dataset.

## EXAMPLES

### EXAMPLE 1:Generates SQL commands for a complete warehouse as master/detail

```powershell
[string[]]$sql= Get-StockSql -filter @("Barcode >= '1000000'", "Barcode <= '8888889'") -alias 'Barcode' -warehouse 'CHICAGO'
```

```sql
-- OUTPUT MASTER $sql[0]
SELECT CONVERT(VARCHAR(100),art.BARCODE) [ID.ALIAS]
FROM [dbo].Lagerort lo
JOIN [dbo].LagerKonto lk on [dbo].lk.Lagerort = lo.id
JOIN [dbo].Artikel [art] ON art.id = lk.artikelId
    AND art.ArtNummer not like '.MUSTER%'
     AND Barcode >= '1000000' AND Barcode <= '8888889' 
WHERE lo.id >= 1000
    AND lo.id < 1400
    AND lk.IdentId IS NULL
    AND lk.PlatzId IS NULL
    AND lo.Bezeichnung = 'CHICAGO'
ORDER BY 1
```

```sql
-- OUTPUT DETAILS $sql[1]
SELECT lk.Menge [BESTANDVERFUEGBAR] 
FROM [dbo].Lagerort lo
JOIN [dbo].LagerKonto lk on [dbo].lk.Lagerort = lo.id
JOIN [dbo].Artikel [art] ON art.BARCODE = '{0}'
WHERE  lk.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE BARCODE = '{0}')
    AND lk.IdentId IS NULL
    AND lk.PlatzId IS NULL
    AND lo.Bezeichnung = 'CHICAGO'
```

```sql
-- OUTPUT LINK $sql[2]
ID.ALIAS
```

In this example, SQL commands are generated that output warehouse quantities for the `CHICAGO` warehouse. The reference in the export is realized via the unique field `Barcode`. The reference always has the field name `ID.ALIAS`, which establishes the connection from the master to the detail.

> With the SQL array as the return value, a data set can then be generated via the `Get-DataFromSql` command, for example, as a nested one.

## PARAMETERS

### -alias
The alias is historically the field 'ArticleNo' (= phys. ARTNUMBER) of the article table.
In an XML output the node is always 'ID.ALIAS'. This alias is used to uniquely associate the record and can now refer to another unique field. Currently these are UID, ID, ARTNUMBER and BARCODE. If BARCODE is used, it must be ensured that the field is unique in the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: ARTNUMMER
Accept pipeline input: False
Accept wildcard characters: False
```

### -filter
The filter is an array of strings and the filtering refers to the master dataset. Each row of the array is added individually to the existing filters via logical AND. By default, items whose item number starts with '.MUSTER' are hidden. For example, a filter could be "BARCODE -ne '4711'".

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

### -legacy
The EULANDA inventory control system historically uses a total stock of all storage locations for the stock quantities.
The field name is 'stock available' (= BESTANDVERFUEGBAR). Additionally there are two calculated stock levels. One is 'Stock with unposted sales' (= BESTANDVERFUEGBAR1). This one reduces the actual stock.
And as last there is still the stock which contains beside it still the transacted but not yet collected orders; this is the stock with 'purchase orders' (= BESTANDVERFUEGBAR2).
If the parameter warehouse is specified, the other two nodes are also output if the legacy switch is set. In this case all have the same content. However, if the parameter warehouse is not passed, then, if legacy is set, the sum of all storage locations and the two calculated nodes are output.

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

### -qtyStatic
If a value is passed here, it overwrites the actual stock in the output. This has the background that for example a connected online store always has all articles in stock. This is very helpful when testing new systems.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
The name of a warehouse can be specified here. In this case it is also a filter, because in this case only the items that are available in this warehouse will be displayed. Warehouses must have been defined within the EULANDA ERP with an account number from 1000-1399.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DataFromSql.md](https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-DataFromSql.md)






