function Test-ArticlePropertyItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange("Positive")]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $articleId = Get-ArticleId @paramsArticle -conn $myConn

        [bool]$result = $false

        [string]$sql = @"
        SELECT CASE WHEN EXISTS
            (SELECT me.ObjektId
                FROM MerkmalElement me
                JOIN Merkmal m ON
                    m.Id = me.KopfId AND
                    m.id = $propertyId AND
                    m.Tabelle = 'Artikel' AND m.MerkmalTyp = 1
            WHERE me.ObjektId = $articleId )
        THEN 1 ELSE 0 END [Item]
"@
        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                if ($rs.fields('Item').Value -eq 1) {
                    $result = $true
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-ArticlePropertyItem -articleNo '206003' -propertyId 1358 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
