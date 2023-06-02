function Get-SalesOrderId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$salesOrderNo
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$salesOrderId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$customerOrderNo
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
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsSalesOrder.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingSalesOrderKeys)
        $value = $firstEntry.Value

        $sqlFrag = "$key = '$value'"
        [string]$sql = "SELECT Id [salesOrderId] FROM Auftrag WHERE $sqlFrag"
        $rs = $myConn.Execute($sql)
        $rs = Get-AdoRs -recordset $rs
        if ($rs) {
            [int]$result = $rs.fields('salesOrderId').Value
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SalesOrderId -salesOrderNo '20230430' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
