function Test-SalesOrder {
    [CmdletBinding()]
    param(
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

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'Sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $firstEntry = $paramsSalesOrder.GetEnumerator() | Select-Object -First 1
        $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingSalesOrderKeys)
        $value = $firstEntry.Value

        $sqlFrag = "$key = '$value'"

        [string]$Sql = "SELECT Id FROM Auftrag WHERE $sqlFrag"
        [bool]$result = $false
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                [bool]$result = $true
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-SalesOrder -customerOrderNo '4711' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
