function Get-ArticleId {
    [CmdletBinding()]
    param (
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

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsArticle.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingArticleKeys)
        $value = [string]$firstEntry.Value
        $value = $value.replace("'","''") # Escape Single Quote in Strings
        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT Id [articleId] FROM Artikel WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [int]$result = $rs.fields('articleId').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ArticleId -barcode '4014751021005' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
