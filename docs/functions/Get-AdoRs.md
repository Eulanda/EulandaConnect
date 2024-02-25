---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-AdoRs.md
schema: 2.0.0
---

# Get-AdoRs

## SYNOPSIS
This PowerShell function returns the first valid and opened recordset due to a query. Source code on [GitHub](https://github.com/Eulanda/EulandaConnect/blob/master/source/public/Get-AdoRs.ps1).

## SYNTAX

```
Get-AdoRs [[-recordset] <Object>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
It takes an ADO recordset as parameter and iterates until an open one is found. If no data is found, $null is returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> $myConn= Get-Conn -udl "C:\temp\Eulanda_1 JohnDoe.udl"
PS C:\> $rs= Get-AdoRs -recordset $myConn.Execute('SELECT * FROM Artikel')
PS C:\> if ($rs) { Write-Host $rs.fields('ArtMatch').value }
```

Here a recordset is used, which is taken as the result of the `execute` method of the connection. Under certain circumstances, several resultsets are delivered with ADO. Get-AdoRs iterates internally with `NextRecordSet` through the different results and returns the first opened recordset. This is usually the one you are looking for.

## PARAMETERS

### -recordset
This is the recordset that contains, among other things, the query. However, it may contain other recordsets. 

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


### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

