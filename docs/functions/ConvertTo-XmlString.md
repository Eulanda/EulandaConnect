---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/ConvertTo-XmlString.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# ConvertTo-XmlString

## SYNOPSIS
This PowerShell function converts ADO (ActiveX Data Objects) field objects into XML strings. It accepts various data types and handles `NULL` values according to the specified options. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/ConvertTo-XmlString.ps1).

## SYNTAX

```
ConvertTo-XmlString [[-adoField] <__ComObject>] [-includeEmpty] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
The `ConvertTo-XmlString` function in PowerShell accepts an ADO field object and an optional switch `-includeEmpty`, which specifies whether empty values should be included in the output or not. The function checks the data type of the passed object and converts its value accordingly into an XML string. For `NULL` values, it returns the default value or an empty value (depending on the `-includeEmpty` option).

## EXAMPLES

### Example 1: Convert an ado date field to an XML string
```powershell
# Create a recordset with a field of type adDBTimeStamp
$rs = New-Object -ComObject ADODB.Recordset
$rs.Fields.Append("MyDateField", $adDBTimeStamp)
$rs.Open()

# Add a new record and set the value to the current date
$rs.AddNew()
$rs.Fields("MyDateField").Value = Get-Date

# Retrieve the ADO object
$adoField = $rs.Fields("MyDateField")

# Convert the ADO object to an XML string using the ConvertTo-XmlString function
$convertedXmlString = ConvertTo-XmlString -adoField $adoField

# Output the converted XML string
Write-Output $convertedXmlString

# Close the recordset and release the used memory
$rs.Close()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($rs) | Out-Null
```

In this example, an ADO recordset is created with a field of type `adDBTimeStamp`. A new record is added, and the field value is set to the current date. Then, the ADO object is converted to an XML string using the `ConvertTo-XmlString` function, and the output is displayed. Finally, the recordset is closed and the used memory is released.

## PARAMETERS

### -adoField
An ADO field object to be converted. This object must be of type `System.__ComObject`.

```yaml
Type: __ComObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeEmpty
An optional switch specifying whether empty values should be included in the output. If this switch is provided, empty values will be used in the output; otherwise, default values will be used.

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS


