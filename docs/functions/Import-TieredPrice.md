---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Import-TieredPrice.md
schema: 2.0.0
---

# Import-TieredPrice

## SYNOPSIS
This function imports tiered prices from a CSV or Excel file into a specified price list of EULANDA ERP system.

## SYNTAX

```
Import-TieredPrice [[-articleNoName] <String>] [[-price1Name] <String>] [[-qty1Name] <String>]
 [[-price2Name] <String>] [[-qty2Name] <String>] [[-price3Name] <String>] [[-qty3Name] <String>]
 [[-price4Name] <String>] [[-qty4Name] <String>] [[-price5Name] <String>] [[-qty5Name] <String>]
 [[-tierListName] <String>] [[-path] <String>] [[-udl] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Import-TieredPrice function uses ADO connection to connect to a database. It imports the tiered prices from a specified CSV or Excel file, and updates the database with the imported prices. The file should contain specific columns for the article number and the prices. The quantities can be optionally specified. If a quantity is not provided for a certain price, a default value of "1" will be used.

The function allows selective updates, meaning you can specify only the price columns you want to update in the target table. If a price column is provided and its associated quantity column is not, the function will update the price for that tier and set the quantity to "1". If a price column is not provided, that tier will not be updated in the database.

The price list name, file path and ADO connection string (UDL file path) are needed as parameters. The function will update the specified price list in the database with the imported prices, matching the articles by the article number.

## EXAMPLES

### Example 1: Import tiered prices from a csv file
```powershell
PS C:\> Import-TieredPrice -path 'C:\temp\test.csv' -articleNoName 'ArticleNo' -price1Name 'SalesPrice' -tierListName 'Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

This command will import the prices from the 'SalesPrice' column of the 'test.csv' file into the 'Retail' price list of the database specified by the 'Eulanda_1 JohnDoe.udl' connection string. The 'ArticleNo' column is used to match the articles in the database.

## PARAMETERS

### -articleNoName
The name of the column that contains the article number in the CSV or Excel file. 

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

### -path
The path to the CSV or Excel file that contains the tiered prices.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price1Name
The name of the column that contain the first price in the CSV or Excel file. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price2Name
The name of the column that contain the second price in the CSV or Excel file. 

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

### -price3Name
The name of the column that contain the third price in the CSV or Excel file. 

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

### -price4Name
The name of the column that contain the fourth price in the CSV or Excel file. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price5Name
The name of the column that contain the fifth price in the CSV or Excel file. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty1Name
The name of the column that contain the first quantity in the CSV or Excel file. 

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

### -qty2Name
The name of the column that contain the second quantity in the CSV or Excel file. 

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

### -qty3Name
The name of the column that contain the third quantity in the CSV or Excel file. 

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

### -qty4Name
The name of the column that contain the fourth quantity in the CSV or Excel file. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty5Name
The name of the column that contain the fifth quantity in the CSV or Excel file. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -tierListName
The name of the price list in the database where the prices will be imported.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -udl
The path to the ADO connection string file (.UDL) for the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
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
