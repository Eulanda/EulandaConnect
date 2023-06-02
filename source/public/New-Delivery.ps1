function New-Delivery {
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
        Test-ValidateSingle -validParams (Get-SingleSalesOrderKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsSalesOrder' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'relevantError' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$result = 0
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsSalesOrder = Get-UsedParameters -validParams (Get-SingleSalesOrderKeys) -boundParams $PSBoundParameters
        $salesOrderId = Get-SalesOrderId @paramsSalesOrder -conn $myConn
        try {
            $sql = @"
                SET NOCOUNT ON
                DECLARE @Af_Id int
                DECLARE @Lf_Id int
                SET @Af_Id = $salesOrderId
                EXEC dbo.cn_TraAfLf_SingleAf @Lf_Id=@Lf_Id OUT, @af_id=@Af_Id
                SELECT @Lf_Id [Id]
"@
            $rs = new-object -comObject ADODB.Recordset
            $rs.CursorLocation = $adUseClient
            $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                if (! $rs.eof) {
                    [int]$result = $rs.fields('Id').value
                }
            } else {
                Throw ((Get-ResStr 'RECORDSET_CLOSED') -f $($myInvocation.MyCommand), $sql)
            }
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw ((Get-ResStr 'ADO_ERROR_EXT') -f $_, $relevantError)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  New-Delivery -salesOrderNo 131 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
