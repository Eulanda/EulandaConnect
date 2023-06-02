function Get-AddressSql {
    [CmdletBinding()]
    param(
        [parameter(Position = 0, Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select = '*'
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [Parameter(Mandatory = $false)]
        [ValidateSet('none', 'upper', 'lower', 'capital', IgnoreCase = $true)]
        [string]$strCase = 'none'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingAddressKeys) })]
        [string]$alias = 'addressMatch'
        ,
        [parameter(Mandatory = $false)]
        [string]$order = $alias
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
        New-Variable -Name 'arrOrder' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'arrSelect' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'fieldList' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFilter' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlLimit' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlMaster' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlOrder' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlRevers' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlSelect' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingAddressKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingAddressKeys)

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
            Id, Match, [Uid],

            /* IDENTIFIER */
            IsNull(FremdRefNr, '') [FremdRefNr], IsNull(FremdNr, 0) [FremdNr],
            IsNull(Fibukonto,0) [Fibukonto], IsNull(ILN,0) [ILN],

            /* GROUPS */
            IsNull(AdresseGr,'') [AdresseGr],

            /* ADDRESS */
            IsNull(Name1, '') [Name1], IsNull(Name2, '') [Name2], IsNull(Name3, '') [Name3],
            IsNull(Strasse, '') [Strasse], IsNull(Plz, '') [Plz], IsNull(Ort, '') [Ort],
            RTrim(LTrim(IsNull(Land, ''))) [Land],

            /* COMMUNICATION */
            IsNull(EMail, '') [EMail], IsNull(Tel, '') [Tel], IsNull(Fax, '') [Fax], IsNull(Auto, '') [Auto],
            IsNull(Homepage, '') [Homepage],

            /* CURRENCY */
            IsNull(Rabatt, '') [Rabatt], IsNull(UstId, '') [UstId],  IsNull(SteuerNr, '') [SteuerNr],
            IsNull(BankIBAN, '') [BankIBAN],  IsNull(BankBIC, '') [BankBIC],

            /* DESCRIPTION */
            IsNull(Karteikarte,'') [Karteikarte],

            /* OTHER */
            IsNull(Warnung,'') [Warnung]

            FROM Adresse

            $sqlFilter
            ) Dummy

            $sqlOrder $sqlRevers
"@
        $result = [string[]]@($sqlMaster)

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AddressSql
}
