function Get-StockSql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [int]$qtyStatic
        ,
        [parameter(Mandatory = $false)]
        [string]$warehouse
        ,
        [parameter(Mandatory = $false)]
        [switch]$legacy
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'qtyFields' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlDetail' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLink' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filter) {
            [string]$sqlFilter= " AND $($filter -join(' AND ')) "
        } else {
            [string]$sqlFilter= ''
        }

        if ($warehouse) {
            # -----------------------------------------------------------------------------
            # Only one warehouse
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS]
            FROM [dbo].Lagerort lo
            JOIN [dbo].LagerKonto lk on lk.Lagerort = lo.id
            JOIN [dbo].Artikel [art] ON art.id = lk.artikelId
                AND art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            WHERE lo.id >= 1000
                AND lo.id < 1400
                AND lk.IdentId IS NULL
                AND lk.PlatzId IS NULL
                AND lo.Bezeichnung = '$warehouse'
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                [string]$qty = $qtyStatic
            } else {
                [string]$qty = 'lk.Menge'
            }

            if ($legacy) {
                [string]$sqlLegacy= ", $qty [BESTANDVERFUEGBAR1], $qty [BESTANDVERFUEGBAR2]"
            } else {
                [string]$sqlLegacy = ""
            }

            [string]$sqlDetail = @"
            SELECT $qty [BESTANDVERFUEGBAR] $sqlLegacy
            FROM [dbo].Lagerort lo
            JOIN [dbo].LagerKonto lk on lk.Lagerort = lo.id
            JOIN [dbo].Artikel [art] ON art.$alias = '{0}'
            WHERE  lk.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}')
                AND lk.IdentId IS NULL
                AND lk.PlatzId IS NULL
                AND lo.Bezeichnung = '$warehouse'
"@
        } elseif ($legacy) {

            # -----------------------------------------------------------------------------
            # All warehouses with sales and purchase correction. Pur legacy support
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS]
            FROM [dbo].Artikel [art]
            WHERE art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                [string]$qtyFields = `
                    "$qtyStatic [BestandVerfuegbar], " +`
                    "$qtyStatic [BestandVerfuegbar1], " +`
                    "$qtyStatic [BestandVerfuegbar2]"
            } else {
                [string]$qtyFields = `
                    "[dbo].[cnf_BestandVerfuegbarGesamt](art.Id,0) [BestandVerfuegbar], " +`
                    "[dbo].[cnf_BestandVerfuegbar1](art.Id,0) [BestandVerfuegbar1], " +`
                    "[dbo].[cnf_BestandVerfuegbar2](art.Id,0) [BestandVerfuegbar2]"
            }

            [string]$sqlDetail = @"
            -- Total inventory from all own warehouses with sales and purchase output fields
            SELECT $qtyFields
            FROM [dbo].Artikel [art]
            WHERE art.$alias = '{0}'
"@

        } else {

            # -----------------------------------------------------------------------------
            # All warehouses , all suplier and totals with sales and purchase correction
            # -----------------------------------------------------------------------------
            # Master
            # ------------------------------------------
            [string]$sqlMaster = @"
            SELECT
                CONVERT(VARCHAR(100),art.$alias) [ID.ALIAS],
                art.Id [ID],
                CONVERT(varchar(36), art.Uid) [UID],
                art.ArtNummer [ARTNUMMER],
                art.Barcode [BARCODE],
                art.ChangeDate [CHANGEDATE],
                art.ShopFreigabeFlg [SHOPFREIGABEFLG],
                art.ShopExportDatum [SHOPEXPORTDATUM]
            FROM [dbo].Artikel [art]
            WHERE art.ArtNummer not like '.MUSTER%'
                $sqlFilter
            ORDER BY 1
"@

            # ------------------------------------------
            # Detail
            # ------------------------------------------
            if ($qtyStatic) {
                $sqlStaticWarehouse = $qtyStatic
                $sql0 = $qtyStatic
                $sql1 = $qtyStatic
                $sql2 = $qtyStatic
                $sqlSupplier = $qtyStatic
            } else {
                $sqlStaticWarehouse = 'lk.Menge'
                $sql0 = '[dbo].[cnf_BestandVerfuegbarGesamt](art.Id,0)'
                $sql1 = '[dbo].[cnf_BestandVerfuegbar1](art.Id,0)'
                $sql2 = '[dbo].[cnf_BestandVerfuegbar2](art.Id,0)'
                $sqlSupplier = 'IsNull(kart.Bestand,0)'
            }

            [string]$sqlDetail = @"
            SELECT * FROM (
                SELECT lo.id [KONTO], UPPER(lo.Bezeichnung) [BEZEICHNUNG], $sqlStaticWarehouse [MENGE]
                FROM [dbo].Lagerort lo
                JOIN [dbo].LagerKonto lk ON lk.Lagerort = lo.id
                JOIN [dbo].Artikel [art] ON art.$alias = '{0}'
                WHERE lo.id >= 1000
                    AND lo.id < 1400
                    AND lk.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}')
                    AND lk.IdentId IS NULL
                    AND lk.PlatzId IS NULL

                -- Total inventory from all own warehouses that is physically present
                UNION
                SELECT 10000+0 [KONTO], 'BESTANDVERFUEGBAR' [BEZEICHNUNG], $sql0 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT 10000+1 [KONTO], 'BESTANDVERFUEGBAR1' [BEZEICHNUNG], $sql1 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT 10000+1 [KONTO], 'BESTANDVERFUEGBAR2' [BEZEICHNUNG], $sql2 [MENGE]
                FROM [dbo].Artikel [art]
                WHERE  art.$alias = '{0}'

                -- Inventory of suppliers, external goods
                UNION
                SELECT 20000+k.id [KONTO], adr.Match [BEZEICHNUNG], $sqlSupplier [MENGE]
                FROM [dbo].Kreditor [k]
                JOIN [dbo].Adresse [adr] ON adr.id = k.AdresseID
                JOIN [dbo].KrArtikel [kart] ON
                    kart.ArtikelId = (SELECT TOP 1 Id FROM [dbo].Artikel WHERE $alias = '{0}') AND
                    kart.KreditorID = k.id
                JOIN [dbo].Artikel [art] ON art.id = kart.ArtikelID
            ) [INVENTORYREPORT] ORDER BY KONTO

"@
        }

    <#
            # This model 'flat' is experimental and not yet fully parameterized

            [string]$sqlMaster = @"
            SELECT  GTIN [ID.ALIAS] FROM
            (SELECT ArtNummer [ArticleNo], Barcode [GTIN] FROM Artikel) [Master]
            WHERE GTIN>='1000000' AND GTIN <='8888889'
    @"

            [string]$sqlDetail = @"
            DECLARE @Id INT
            DECLARE @IdList TABLE (Id INT)

            INSERT INTO @IdList SELECT Id FROM Artikel order by id -- VALUES (31), (32), (33)
            DECLARE @Result TABLE ([Uid] VARCHAR(36), ArticleId INT, ArticleNo VARCHAR(80), GTIN VARCHAR(80),
                ChangeDate DateTime, ExportFlag Bit, ExportDate DateTime, StockGroup INT, Warehouse VARCHAR(50), Quantity INT)
            DECLARE IdCursor CURSOR FOR SELECT Id FROM @IdList

            OPEN IdCursor
            FETCH NEXT FROM IdCursor INTO @Id

            WHILE @@FETCH_STATUS = 0
            BEGIN
            INSERT INTO @Result
                -- Inventory from own warehouses
                SELECT CONVERT(varchar(36), art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode,'') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    lo.id [StockGroup], UPPER(lo.Bezeichnung) [Warehouse], lk.Menge [Quantity]
                FROM Lagerort lo
                JOIN dbo.LagerKonto lk on lk.Lagerort = lo.id
                JOIN Artikel [art] ON art.id = @Id AND art.ArtNummer not like '.MUSTER%'
                WHERE lo.id >= 1000
                    AND lo.id < 1400
                    AND lk.ArtikelId = @Id
                    AND lk.IdentId IS NULL
                    AND lk.PlatzId IS NULL

                -- Total inventory from all own warehouses that is physically present
                UNION
                SELECT CONVERT(varchar(36), art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode,'') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+1 [StockGroup], 'AVAILABLE' [Warehouse], [dbo].[cnf_BestandVerfuegbarGesamt](@Id,0) [Quantity]
                FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Total inventory from all own warehouses less sales orders
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+2 [StockGroup], 'SALES' [Warehouse], [dbo].[cnf_BestandVerfuegbar1](@Id,0) [Quantity]
                FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Total inventory from all own warehouses less sales orders and plus purchase orders
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    10000+3 [StockGroup], 'PURCHASE' [Warehouse], [dbo].[cnf_BestandVerfuegbar2](@Id,0) [Quantity] FROM Artikel [art]
                WHERE art.id = @Id AND art.ArtNummer not like '.MUSTER%'

                -- Inventory of suppliers, external goods
                UNION
                SELECT CONVERT(varchar(36),art.Uid) [Uid], art.Id [ArticleId], art.ArtNummer [ArticleNo], IsNull(Art.Barcode, '') [GTIN],
                    art.ChangeDate [ChangeDate], art.ShopFreigabeFlg [ExportFlag], art.ShopExportDatum [ExportDate],
                    20000+k.id [StockGroup], adr.Match [Warehouse], IsNull(kart.Bestand,0) [Quantity]
                FROM Kreditor [k]
                JOIN Adresse [adr] ON adr.id = k.AdresseID
                JOIN KrArtikel [kart] ON  kart.ArtikelId = @Id AND kart.KreditorID = k.id
                JOIN Artikel [art] ON art.id = kart.ArtikelID AND art.ArtNummer not like '.MUSTER%'

                FETCH NEXT FROM IdCursor INTO @Id
            END

            CLOSE IdCursor
            DEALLOCATE IdCursor

            SELECT GTIN [ARTNUMMER], Quantity [BESTANDVERFUEGBAR],  Quantity [BESTANDVERFUEGBAR1], Quantity [BESTANDVERFUEGBAR2] FROM
            (SELECT [Uid], ArticleId, ArticleNo, GTIN,
                    ChangeDate, ExportFlag, ExportDate,
                    StockGroup, Warehouse, Quantity
            FROM @Result) [Details]

            WHERE StockGroup = 1001 AND GTIN>='1000000' AND GTIN <='8888889' AND GTIN = '{0}'
"@

    #>

       [string]$sqlLink= 'ID.ALIAS'

       $result = @($sqlMaster, $sqlDetail, $sqlLink)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
   # Test:  Get-StockSql -legacy -filter "ArtNummer='130100'"
}
