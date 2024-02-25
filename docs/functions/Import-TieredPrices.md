---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Import-TieredPrices.md
schema: 2.0.0
---

# Import-TieredPrices

## SYNOPSIS
This function imports tiered prices from a CSV or Excel file into a specified price list of the EULANDA ERP system.

## SYNTAX

```
Import-TieredPrices [[-barcodeName] <String>] [[-articleNoName] <String>] [[-articleIdName] <String>]
 [[-articleUidName] <String>] [[-price1Name] <String>] [[-qty1Name] <String>] [[-price2Name] <String>]
 [[-qty2Name] <String>] [[-price3Name] <String>] [[-qty3Name] <String>] [[-price4Name] <String>]
 [[-qty4Name] <String>] [[-price5Name] <String>] [[-qty5Name] <String>] [[-priceList] <String>]
 [[-priceListId] <Int32>] [[-csvDelimiter] <String>] [[-decimalSeparator] <String>] [[-path] <String>]
 [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Import-TieredPrices** function uses an ADO connection to connect to the EULANDA database. It imports tiered prices from a specified CSV or Excel file and updates the database's tiered price table.

If Excel files should be applied, the `XSLX` format must be used. Also, the ImportExcel PowerShell module must be installed. This can be done at the PowerShell prompt with `Install-Module ImportExcel`. No installed Office is required to import Excel files.

For `CSV` files, however, field separation with semicolons is expected. The price and quantity fields are expected as from the country setting of the PC. So in Germany for example the comma to separate the cents.

The file to be imported must contain a column with the article number and at least one price field. The column names are freely selectable, as already mentioned. If no corresponding quantity is specified, `1` is used as default value. This means that the price is used from quantity `1`.

The parameters `Price1Name` to `Price5Name` are the field names from the file to be imported. The number in the parameter is used to specify the scale in the price list.

`-price1Name` contains the field name for the first scale and so on. It is not mandatory to start with the first price, in this way every scale from `1` to `5` can be addressed in the ERP system.

EULANDA supports any number of price lists. By specification of the `-priceList` the price list to be used is selected.

As a further parameter the file path to the UDL file is needed.

## EXAMPLES

### Example 1: Import tiered prices from a csv file
```powershell
PS C:\> Import-TieredPrices -path 'C:\temp\test.csv' -articleNo 'ArticleNo' -price1 'SalesPrice' -priceList 'Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

```
ArticleNo;EAN;SalesPreis
40509;4052398405093;31,5
40511;4052398405116;52,5
40510;4052398405109;31,5
20002;4052398200025;231,85
40487;4052398404874;378,57
30305;4052398303054;5,25
30306;4052398303061;13,65
30308;4052398303085;10,5
30309;4052398303092;18,9
30310;4052398303108;25,2
30307;4052398303078;21
40504;4052398405048;550
20096;4052398200964;66,33
20066;4052398200667;66,33
```

This command will import the prices from the `-salesPrice` column of the `test.csv` file into the `Retail` price list of the database specified by the `Eulanda_1 JohnDoe.udl` connection string. The `-articleNo` column is used to match the articles in the database. 

The semicolon is used as field delimiter. This value can be changed via the `-csvDelimiter` parameter. The separation to the cents is specified via the decimal separator, which is read by the operating system. However, one can override this value with `-decimalSeparator`.

In this sample file, the field `EAN` is ignored. Only one price is inserted in the pricelist as price1.

## PARAMETERS

### -articleIdName
The name of the column that contains the article Id in the CSV or Excel file. Only one field name from the selection `-articleNoName`, `-articleIdName`, `-barcodeName`, `-articleUidName` may be specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: articleId

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -articleNoName
The name of the column that contains the article number in the CSV or Excel file. Only one field name from the selection `-articleNoName`, `-articleIdName`, `-barcodeName`, `-articleUidName` may be specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: articleNo

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -articleUidName
The name of the column that contains the article uid in the CSV or Excel file. Only one field name from the selection `-articleNoName`, `-articleIdName`, `-barcodeName`, `-articleUidName` may be specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: articleUid

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -barcodeName
The name of the column that contains the article barcode in the CSV or Excel file. Only one field name from the selection `-articleNoName`, `-articleIdName`, `-barcodeName`, `-articleUidName` may be specified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: barcode

Required: False
Position: 0
Default value: None
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
Position: 19
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
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -csvDelimiter
The CSV delimiter is used with CSV files. The semicolon is used as default. It can be changed via this parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases: delim

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -decimalSeparator
The decimal separator for floating point numbers such as prices or quantities. The value from the operating system is used by default. In Germany, for example, this would be the comma. With this parameter the value can be changed. Especially with CSV files this can be necessary if they use the point like in international files.

```yaml
Type: String
Parameter Sets: (All)
Aliases: decimal

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
The path to the **CSV** or **Excel** file containing the tiered prices. Only .csv and .xlsx are accepted as file extension. Note that for Excel files, the PowerShell module `ImportExcel` from the PowerShell Gallery must be installed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price1Name
The name of the column that contain the first price in the CSV or Excel file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: price1

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price2Name
The name of the column that contain the second price in the CSV or Excel file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: price2

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price3Name
The name of the column that contain the third price in the CSV or Excel file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: price3

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price4Name
The name of the column that contain the fourth price in the CSV or Excel file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: price4

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price5Name
The name of the column that contain the fifth price in the CSV or Excel file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: price5

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priceList
The name of the price list into which the scale prices are to be imported. The price list can be specified with either `-priceList` or `-priceListId`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priceListId
The Id of the price list into which the scale prices are to be imported. The price list can be specified with either `-priceList` or `-priceListId`.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty1Name
The name of the column that contain the first quantity in the CSV or Excel file. If the parameter is not specified, the default `1` is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: qty1

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty2Name
The name of the column that contain the second quantity in the CSV or Excel file. If the parameter is not specified, the default `1` is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: qty2

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty3Name
The name of the column that contain the third quantity in the CSV or Excel file. If the parameter is not specified, the default `1` is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: qty3

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty4Name
The name of the column that contain the fourth quantity in the CSV or Excel file. If the parameter is not specified, the default `1` is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: qty4

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty5Name
The name of the column that contain the fifth quantity in the CSV or Excel file. If the parameter is not specified, the default `1` is used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: qty5

Required: False
Position: 13
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
Position: 20
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

