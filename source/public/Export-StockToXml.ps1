Function Export-StockToXml {
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
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
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
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ('')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)

        if ((! $warehouse) -and (! $legacy)) {
            [string]$nodeName = 'LAGERLISTE'
        } else {
            [string]$nodeName = 'LAGER'
        }

        [string[]]$sql= Get-StockSql -filter $filter -alias $alias -qtyStatic $qtyStatic -warehouse $warehouse -legacy:$legacy
        [System.Object]$data = Get-DataFromSql -sql $sql -conn $myConn -arrRoot $nodeName
        [xml]$xml = Convert-DataToXml -data $data -metadata -root 'EULANDA' -arrRoot 'ARTIKELLISTE' -arrSubRoot 'ARTIKEL'

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-StocktoXml -path "C:\Temp\Stock.xml" -udl "C:\Git\Powershell\ProcosSystem\EULANDA_1 ProcosUSA.udl"
 }
