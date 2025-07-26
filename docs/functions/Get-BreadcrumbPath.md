---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-BreadcrumbPath.md
schema: 2.0.0
lastMod: 2024-03-19T06:27:25
---

# Get-BreadcrumbPath

## SYNOPSIS
This PowerShell function returns the breadcrumb path of a given breadcrumb ID. This function requires an EULANDA ERP system. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-BreadcrumbPath.ps1).

## SYNTAX

```
Get-BreadcrumbPath [[-breadcrumbId] <Int32>] [[-conn] <Object>] [[-udl] <String>] [[-connStr] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The `Get-BreadcrumbPath` function retrieves the breadcrumb path of a specific node in the Eulanda property tree. The `breadcrumbId` parameter specifies the ID of the node for which the breadcrumb path is retrieved. The function can access the Eulanda database using either an ADO COM-object, a UDL file or a connection string.

## EXAMPLES

### Example 1:Returns the breadcrumb path of  ID 756
```powershell
PS C:\> Get-BreadcrumbPath -breadcrumbId 756 -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
```

```
\Shop\Profi-Aqua\Make-Up
```

Returns the breadcrumb path of the breadcrumb with ID 756 using a UDL file.

## PARAMETERS

### -breadcrumbId
Specifies the ID of the breadcrumb to retrieve the path for.

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

## RELATED LINKS


