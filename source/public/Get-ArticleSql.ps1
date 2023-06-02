function Get-ArticleSql {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select = (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [string]$order= $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$noIdAlias
        ,
        [parameter(Mandatory = $false)]
        [ValidateRange(0, [int]::MaxValue)]
        [Nullable[int]]$limit
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'arrOrder' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrSelect' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'fieldList' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLimit' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlOrder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlRevers' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlSelect' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($filter) {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '') AND $($filter -join(' AND ')) "
        } else {
            [string]$sqlFilter= "WHERE ( RTrim(LTrim(IsNull($alias,'')))  <> '')"
        }

        if ($order) {
            [string]$sqlOrder = "ORDER BY dummy.$order"
        } else {
            [string]$sqlOrder = ''
        }

        $sqlSelect = $select
        if ($sqlSelect -ne '*') {
            if (! ($SqlSelect.Contains($alias, [System.StringComparison]::InvariantCultureIgnoreCase))) {
                $sqlSelect = "$alias,$sqlSelect"
            }

            if ($order) {
                [string[]]$arrOrder = $order -split ','
                for ($i=0; $i -lt $arrOrder.count-1; $i++) {
                    # Delete ASC and DESC
                    $arrOrder[$i] = $arrOrder[$i].Split(' ')[0]
                    if ($SqlSelect.Contains($arrOrder[$i], [System.StringComparison]::InvariantCultureIgnoreCase)) {
                        $arrOrder[$i] = ''
                    }
                }
                $arrOrder = $arrOrder | Where-Object { $_ -ne "" }
                $fieldList = $arrOrder -join ','
                if ($fieldList) {
                    $sqlSelect = "$fieldlist,$SqlSelect"
                }
            }
        }

        if (! ($null -eq $limit)) {
            $sqlLimit = "TOP $limit"
        } else {
            $SqlLimit = ''
        }

        if ($revers) {
            $sqlRevers = 'DESC'
        } else {
            $sqlRevers = ''
        }

        $arrSelect = $sqlSelect -split ','
        $arrSelect = $arrSelect | ForEach-Object { $_.Trim() }
        if ($reorder) {
              $arrSelect = $arrSelect | Sort-Object
        }
        $arrSelect = $arrSelect | ForEach-Object { Convert-StringCase -value $_ -strCase $strcase }
        $arrSelect = $arrSelect | Get-Unique

        $sqlSelect = $arrSelect -join ','

        if (! ($noIdAlias)) {
            $sqlSelect = "$alias [ID.ALIAS], $sqlSelect"
        }

        [string]$sqlMaster = @"
            SELECT $sqlSelect FROM (
            SELECT
            $sqlLimit
            /* KEYS */
            Id, ArtNummer, IsNull(Barcode,'') [Barcode], [Uid],

            /* IDENTIFIER */
            IsNull(ArtMatch,'') [ArtMatch], IsNull(ArtNummerErsatz,'') [ArtNummerErsatz],
            IsNull(ArtNummerHersteller,'') [ArtNummerHersteller],

            /* GROUPS */
            IsNull(RabattGr,'') [RabattGr], IsNull(WarenGr,'') [WarenGr],
            IsNull(ErloesGr,'') [ErloesGr], VerpackEh, PreisEh, MengenEh,

            /* CURRENCY */
            Waehrung, MwStGr, MwStSatz, EkNetto, IsNull(Ek2Netto,0.0)[Ek2Netto], BruttoFlg,
            Vk, VkNetto, VkBrutto,

            /* SHOP */
            IsNull(ShopExportDatum,'1900-01-01') [ShopExportDatum], ShopFreigabeFlg,

            /* FLAGS */
            AuslaufFlg, NeuFlg, SonderFlg, LoeschFlg,

            /* INTRASTAT */
            IsNull(Upper(UrsprungsLand),'')[UrsprungsLand],
            IsNull(UrsprungsRegion,'') [UrsprungsRegion], IsNull(WarenNr,'') [WarenNr],

            /* DESCRIPTION */
            IsNull(Ultrakurztext,'') [UltraKurztext], IsNull(Kurztext1,'') [Kurztext1],
            IsNull(Kurztext2,'') [Kurztext2], IsNull(Info,'') [Info], IsNull(Langtext,'') [Langtext],

            /* OTHER */
            Gewicht, Volumen, IsNull(Warnung,'') [Warnung], IsNull(Lagerplatz,'') [Lagerplatz], LagerTyp,
            ChangeDate

            FROM Artikel

            $sqlFilter
            ) Dummy

            $sqlOrder $sqlRevers
"@

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return [string[]]@($sqlMaster)
    }
    # Test:  Get-ArticleSql  -filter "ArtNummer='130100'"
}
