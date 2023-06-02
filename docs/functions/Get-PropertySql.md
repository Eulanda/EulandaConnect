---
external help file: EulandaConnect-help.xml
Module Name: EulandaConnect
online version: https://github.com/Eulanda/EulandaConnect/blob/master/docs/Get-PropertySql.md
schema: 2.0.0
---

# Get-PropertySql

## SYNOPSIS
Generates the SQL statement used by Get-XmlEulandaProperty

## SYNTAX

```
Get-PropertySql [[-breadcrumbPath] <String>] [[-tablename] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates the SQL command used internally by Get-XmlEulandaProperty. The path where the select statement will retrieve the data is specified through the `-breadcrumbPath` parameter. The table on which the property tree is based is specified through the `-tablename` parameter. Valid values for `-tablename` are `Article`, `Address`, and `Delivery`.

## EXAMPLES

### Example 1:Creates the SQL command for exporting a property tree
```powershell
PS C:\> Get-PropertySql -breadcrumbPath '\Shop' -tablename 'Article'
```

```sql
-- Format path 'subpath1\subpath2\subpath3' without leading or trailing backslashes
        DECLARE @BreadcrumbPath VARCHAR(100) = '\Shop';
        SET @BreadcrumbPath = REPLACE(@BreadcrumbPath, '\\', '')
        IF LEFT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 2, LEN(@BreadcrumbPath) - 1)
        IF RIGHT(@BreadcrumbPath, 1) = '\' SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, 1, LEN(@BreadcrumbPath) - 1)
        SET @BreadcrumbPath = LTRIM(RTRIM(@BreadcrumbPath))


    DECLARE @ParentId INT = NULL;
    DECLARE @BreadcrumbId INT = NULL;
    DECLARE @Crumb VARCHAR(1024);

    SELECT @ParentId=Id From merkmal where tabelle = 'artikel' and merkmaltyp=0 and ParentId is Null
    WHILE LEN(@BreadcrumbPath) > 0
    BEGIN
      SET @Crumb = LEFT(@BreadcrumbPath, CHARINDEX('\', @BreadcrumbPath + '\') - 1);
      SET @BreadcrumbPath = SUBSTRING(@BreadcrumbPath, LEN(@Crumb) + 2, 1024);
      SELECT @ParentId = Id
        FROM Merkmal
        WHERE [Name] = @Crumb AND
          IsNull(ParentId, -1) = IsNull(@ParentId, -1)  AND
          Tabelle = 'artikel';
      IF @@ROWCOUNT = 0 SET @ParentId = -1;
    END;

    SET @BreadcrumbId = @ParentId;
    -- Result is: @BreadcrumbId
    -- Select the tree starting with the BreadcrumpID. If no ID is provided, select the entire tree.
    WITH CTE AS (
        SELECT
            ID, ParentID, Name, UID,
            CASE WHEN MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
            Beschreibung, SqlBedingung, Color
        FROM Merkmal
        WHERE
          ID = @BreadcrumbID
          AND Tabelle = 'artikel'
          AND NOT Name LIKE '.%'
        UNION ALL
        SELECT
          t.ID, t.ParentID, t.Name, t.UID,
          CASE WHEN t.MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
          t.Beschreibung, t.SqlBedingung, t.Color
        FROM Merkmal t
          JOIN CTE c ON t.ParentID = c.ID
        WHERE
          t.Tabelle = 'artikel'
          AND NOT t.Name LIKE '.%'
    )
    SELECT ID, ParentID, Name, UID, Sort, Color
    FROM CTE
    ORDER BY ParentId, Sort, Name;
```

The example demonstrates how to use the `Get-PropertySql` cmdlet to generate the SQL command that is internally used by `Get-XmlEulandaProperty`. The `-breadcrumbPath` parameter specifies the path where the select statement retrieves the data, while the `-tablename` parameter specifies the table to which the property tree refers. The generated SQL command is then used to retrieve the property tree data from the database.

## PARAMETERS

### -breadcrumbPath
Specifies the root of a property tree path starting with a backslash `\`. This parameter is used to search for the corresponding branch in the property tree and retrieve its ID. The retrieved ID is used the tree from that point.

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

### -tablename
The parameter specifies the name of the table for which the property tree should be exported. Currently, three tables are supported: Article, Address, and Delivery. The valid table names can be retrieved using the `Get-MappingTablename` function, which allows input in both the native and English names.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
