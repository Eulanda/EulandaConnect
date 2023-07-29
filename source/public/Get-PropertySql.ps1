function Get-PropertySql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbRoot = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbRoot', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        New-Variable -Name 'BreadcrumbSql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string[]]@())
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$BreadcrumbSql = Get-BreadcrumbId -breadcrumbPath $breadcrumbRoot -tablename $tablename

        [string]$sql = @"
            $BreadcrumbSql
            -- Select the tree starting with the BreadcrumpID. If no ID is provided, select the entire tree.
            WITH CTE AS (
                SELECT
                    ID, ParentID, Name, UID,
                    CASE WHEN MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
                    Beschreibung, SqlBedingung, Color
                FROM Merkmal
                WHERE
                    ID = @BreadcrumbID
                    AND Tabelle = '$tablename'
                    AND NOT Name LIKE '.%'
                UNION ALL
                SELECT
                    t.ID, t.ParentID, t.Name, t.UID,
                    CASE WHEN t.MerkmalTyp = 2 THEN 1 Else MerkmalTyp END [Sort],
                    t.Beschreibung, t.SqlBedingung, t.Color
                FROM Merkmal t
                    JOIN CTE c ON t.ParentID = c.ID
                WHERE
                    t.Tabelle = '$tablename'
                    AND NOT t.Name LIKE '.%'
            )
            SELECT ID, ParentID, Name, UID, Sort, Color
            FROM CTE
            ORDER BY ParentId, Sort, Name;
"@
        [string[]]$result = @($sql)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-PropertySql -breadcrumbRoot '\Shop' -tablename 'Article'
}
