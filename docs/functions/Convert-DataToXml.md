---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Convert-DataToXml.md
schema: 2.0.0
---

# Convert-DataToXml

## SYNOPSIS
Converts data structures like nested hashtables or arrays into an XML

## SYNTAX

```
Convert-DataToXml [[-data] <Object>] [-metadata] [[-strCase] <String>] [[-root] <String>] [[-arrRoot] <String>]
 [[-arrSubRoot] <String>] [<CommonParameters>]
```

## DESCRIPTION
The data structures can contain nested hashtables combined with arrays, which may also contain hashtables. Additionally, an array containing hashtables can be passed directly. For cases involving arrays, a separate array root name can be specified, allowing for the creation of a plural form, such as 'Records' and its corresponding 'Record' elements.

The notation for node names can be set via a parameter, which is particularly useful when dealing with data from external databases.

At the moment, pure arrays of simple data types, such as arrays of integers or arrays containing only simple data types, are not supported. However, these have not been encountered in previous work with databases.

An alternative approach is to use the built-in ConvertTo-Xml function. Although this function returns the field name and value in two separate nodes, it is a good choice if you require data types. To use this function, call: `[xml]$xml = $data | ConvertTo-Xml`.

## EXAMPLES

### EXAMPLE 1:Sample for a metablock
```xml
<EULANDA>
	<METADATA>
        <VERSION>1.22</VERSION>/VERSION>
		<GENERATOR>EulandaConnect</GENERATOR>
		<DATEFORMAT>ISO8601</DATEFORMAT>
		<FLOATFORMAT>US</FLOATFORMAT>
		<COUNTRYFORMAT>ISO2</COUNTRYFORMAT>
		<FIELDNAMES>NATIVE</FIELDNAMES>
		<DATE>2023-02-16T13:05:12</DATE>
		<PCNAME>PC4ALL</PCNAME>
		<USERNAME>DOE</USERNAME>
	</METADATA>
</EULANDA>
```

A meta block, when the `metadata` parameter is used, would appear as the first node after the root in the generated XML. This block is created by the `Write-XmlMetadata` function, which is implicitly called when the `metadata` parameter is specified. The meta block provides additional information about the XML structure, such as data types or other relevant metadata.

### EXAMPLE 2:A hash table containing arrays of hash tables is converted to XML
```powershell
$data = [ordered]@{
	"Name" = "John Doe";
    "City" = "New York";
    "Items" =  @(
        [ordered]@{ "Field1" = "Value1"; "Field2" = "Value2" },
        [ordered]@{ "Field3" = "Value3"; "Field4" = "Value4" }
    )
}
[xml]$xml = Convert-DataToXml -data $data -arrRoot 'ITEMS' -arrSubRoot 'ITEM'
$xml.Save("C:\Temp\MyData.xml")
```

```xml
<ROOT>
	<NAME>John Doe</NAME>
	<CITY>New York</CITY>
	<ITEMS>
    	<ITEM>
        	<FIELD1>Value1</FIELD1>
	        <FIELD2>Value2</FIELD2>
    	</ITEM>
	    <ITEM>
        	<FIELD3>Value3</FIELD3>
        	<FIELD4>Value4</FIELD4>
    	</ITEM>
	</ITEMS>
</ROOT>
```

In this example, there is a hash table that contains a field with an array of hash tables at the end. 

### EXAMPLE 3:An array of hash tables is converted to XML

```powershell
$data = @(
[ordered]@{ "Field1" = "Value1"; "Field2" = "Value2" },
[ordered]@{ "Field3" = "Value3"; "Field4" = "Value4" }
)

[xml]$xml = Convert-DataToXml -data $data 
$xml.Save("C:\Temp\MyData.xml")
```

```xml
<ROOT>
	<RECORDS>
		<RECORD>
			<FIELD1>Value1</FIELD1>
			<FIELD2>Value2</FIELD2>
		</RECORD>
		<RECORD>
			<FIELD3>Value3</FIELD3>
			<FIELD4>Value4</FIELD4>
		</RECORD>
	</RECORDS>
</ROOT>
```

In this example, the structure starts with an array. This is where the arrRoot parameter comes into play, which then holds the individual records of the hash tables. The node is then used from the arrSubRoot parameter. The default is for arrRoot = 'Records' and for arrSubRoots 'Record'.

## PARAMETERS

### -arrRoot
If a structure starts with an array, or it is arrays of arrays, there is no possibility to take a field name. For this case it is possible to use a node name, which should be in plural like `ITEMS`. The default is `Records`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Records
Accept pipeline input: False
Accept wildcard characters: False
```

### -arrSubRoot
When arrays of hash tables are formed, the field containing the array is called, for example, `Items`. `arrSubRoot` are the child items of that. In the case here it should be `item`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Record
Accept pipeline input: False
Accept wildcard characters: False
```

### -data
The data parameter contains the data structure to be converted into an XML file.
So for example a hashtable variable `$h = @{ "Field1" = "Value1"; "Field2" = "Value2" }`

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -metadata
If the switch metadata is passed, then an ERP-specific metablock is output as the first node.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -root
The parameter specifies the name of the root in the XML. The default is `Root`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Root
Accept pipeline input: False
Accept wildcard characters: False
```

### -strCase
The node names in the XML are always sensitive to upper and lower case. This parameter can be used to standardize the spelling.
The default is `upper`, you can make the following settings:

| Command | Meaning                             |
| ------- | ----------------------------------- |
| none    | keep spelling                       |
| upper   | upper case                          |
| lower   | lowercase letters                   |
| capital | only the first letter in upper case |

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Upper
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects
## OUTPUTS

### System.Xml.XmlDocument
## NOTES

## RELATED LINKS

[Convert-DataToXml](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Convert-DataToXml.ps1)

[Write-XmlMetadata](Write-XmlMetadata.md)
