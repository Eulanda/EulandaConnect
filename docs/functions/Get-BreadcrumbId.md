---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-BreadcrumbId.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-BreadcrumbId

## SYNOPSIS
This PowerShell function retrieves the ID of the last breadcrumb element in a given property tree path. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-BreadcrumbId.ps1).

## SYNTAX

```
Get-BreadcrumbId [[-breadcrumbPath] <String>] [[-tablename] <String>] [[-conn] <Object>] [[-udl] <String>]
 [[-connStr] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This command retrieves the ID of the last element of a breadcrumb path in the property tree. The `breadcrumbPath` parameter specifies the root of the path, which starts with a backslash `\`. The `tablename` parameter specifies the name of the table that the property tree refers to. The retrieved ID is used to retrieve corresponding data in the database.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-BreadcrumbId -breadcrumpPath '\Shop\Profi-Aqua\Make-Up' -tablename 'Article' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

```
756
```

Returns the ID of the breadcrumb element with the path `\Shop\Profi-Aqua\Make-Up`.

## PARAMETERS

### -breadcrumbPath
Specifies the root of a property tree path starting with a backslash (`\`). This parameter is used to search for the corresponding branch in the property tree and retrieve the ID of the ending path element.

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
A `ConnectionString` can be specified here, with which a database can be opened.

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

### -tablename
Specifies the name of the table the property tree is associated with. Currently supported values for `tablename` are `Article`, `Address`, and `Delivery`.

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


