function Close-SalesOrder {
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

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'relevantError' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $salesOrderId = Get-SalesOrderId @paramsSalesOrder -conn $myConn

        if ($salesOrderId)  {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @SalesOrderId int
            SET @SalesOrderId = $salesOrderId
            EXEC dbo.cn_afBuchen @af_id=@SalesOrderId
"@
        } else {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @SalesOrderNo int
            SET @SalesOrderId = $salesOrderNo
            EXEC dbo.cn_afBuchen @af_Nummer=@SalesOrderNo
"@
        }

        try {
            $myConn.Execute($sql) | out-null
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw  "Error: $_! $relevantError"
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:   Close-SalesOrder -salesOrderNo 131 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
