---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Import-ArticleFromXml.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Import-ArticleFromXml

## SYNOPSIS
The `Import-ArticleFromXml` function is used to import article data from an XML source into a EULANDA database.

## SYNTAX

```
Import-ArticleFromXml [[-xml] <String>] [[-path] <String>] [-cuSurcharge] [-show] [[-conn] <Object>]
 [[-udl] <String>] [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Import-ArticleFromXml` function is a robust utility designed to handle the importation of article data from an XML source into a EULANDA database. The function is flexible, allowing the XML data to be passed as a string (`xmlString`) or sourced from a file (`path`).

The function utilizes ADO (ActiveX Data Objects) Recordset objects to interact with the database, facilitating the retrieval, manipulation, and writing of data.

At the beginning of the function, a connection to the database is established through one of three ways: a direct connection object (`conn`), a UDL file (`udl`), or a connection string (`connStr`). The function performs validation checks to ensure that a valid connection method has been provided and that the XML data is sourced from either `xmlString` or `path`.

Once the XML data is loaded, it is parsed to extract information about each article, including its properties and related price data. This information is processed and then written into the database. Notably, the function has the ability to discern whether an article already exists within the database. If the article does exist, the function merely updates the existing price data. Conversely, if the article does not exist, the function creates a new database entry and populates it with the article information.

> A special feature is the processing of the copper metal surcharge DEL. This is transferred in field UserN3 and added to the sales price when the articles are imported. The metal surcharge is always expected per unit. If the article has a price unit greater than 1, the metal surcharge is multiplied by this price unit before it is added. This special feature only comes into effect if the sales price is net, i.e. without VAT.

## EXAMPLES

### Example 1: Imports an XML file into the EULANDA ERP Database
```powershell
PS C:\> $datanorm = Convert-FromDatanorm -path "C:\Users\john\Desktop\datanorm\Test\datanorm.001" -cuDel 879
PS C:\> $xml = Convert-DatanormToXml -datanorm $datanorm
PS C:\> Import-ArticleFromXml -xml $xml -udl 'C:\temp\Eulanda_1 johndoe.udl'
```

```xml
<EULANDA>
    <METADATA>
        <VERSION>3.2.1</VERSION>
        <GENERATOR>EulandaConnect</GENERATOR>
        <DATEFORMAT>ISO8601</DATEFORMAT>
        <FLOATFORMAT>US</FLOATFORMAT>
        <COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
        <FIELDNAMES>NATIVE</FIELDNAMES>
        <DATE>2023-06-23T22:50:11</DATE>
        <PCNAME>DADOSTUDIO</PCNAME>
        <USERNAME>CN</USERNAME>
    </METADATA>
    <ARTIKELLISTE>
        <ARTIKEL>
            <ARTNUMMER>8241335</ARTNUMMER>
            <ARTMATCH>EVB 10/265 A2</ARTMATCH>
            <BARCODE>4003899170225</BARCODE>
            <ARTNUMMERERSATZ>456 01 31</ARTNUMMERERSATZ>
            <VKNETTO>2.57</VKNETTO>
            <PREISEH>1</PREISEH>
            <MENGENEH>Stk</MENGENEH>
            <VERPACKEH>1</VERPACKEH>
            <RABATTGR>EM01</RABATTGR>
            <WARENGR>01</WARENGR>
            <KURZTEXT1>ELTROPA Verdrahtungsbrücke 1ph 265mm sw</KURZTEXT1>
            <KURZTEXT2>EVB 10/265 A2 10qmm Stift isol</KURZTEXT2>
            <ULTRAKURZTEXT>ELTROPA Verdrahtungsbrücke 1ph 265mm sw</ULTRAKURZTEXT>
            <LANGTEXT>ELTROPA Verdrahtungsbrücke 1ph 265mm sw
EVB 10/265 A2 10qmm Stift isol</LANGTEXT>
            <USERN3>0.18225</USERN3>
        </ARTIKEL>
    </ARTIKELLISTE>      
</EULANDA>
```

Reads a Datanorm file into a PowerShell object. Subsequently, the PowerShell object is converted into an XML file and finally imported into the SQL database of the EULANDA ERP. The database connection is established via a UDL file.

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

### -cuSurcharge
The XML import is a general approach to import data natively into the EULANDA ERP system. The format is as far as possible compatible to the EULANDA-ERP software from the year 2000. The copper processing uses a user field UserN3, which contains the copper added value of the article. This is added to the purchase and sales price during import. The price unit of the item is taken into account. If the price unit is specified as more than 1, the value in UserN3 is multiplied by this factor. The UserN3 field, in turn, is maintained by the Datanorm import function and always refers to a unit of the article, so it is independent of the price unit.

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

### -path
The path to the XML file containing the article data.

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

### -show
Displays a progress bar during execution.

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

### -xml
An XML string containing the article data.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


