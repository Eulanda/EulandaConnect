function New-PurchaseOrder {
    [CmdletBinding()]
    param(
        [int]$supplierID
        ,
        [string]$processedBy
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
        New-Variable -Name 'cmd' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'purchaseOrderNo' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $cmd = New-Object -ComObject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 #adCmdStoredProc
        $cmd.CommandText = "[dbo].[cn_KfNew]"

        $cmd.Parameters.Append(($cmd.CreateParameter("@KreditorId", 3, 1,4, $supplierID))) #adInteger
        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfId", 3, 2))) #adInteger, adParamOutput
        $cmd.Parameters.Append(($cmd.CreateParameter("@KopfNummer", 200, 2, 255))) #adVarWChar, adParamOutput
        $cmd.Parameters.Append(($cmd.CreateParameter("@BearbeitetDurch", 200, 1, 255, $processedBy))) #adVarWChar

        $cmd.Execute() | Out-Null

        $result = $cmd.Parameters.Item("@KopfId").Value

        if ($result) {
            $purchaseOrderNo = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -conn $myConn
            if ($purchaseOrderNo) {
                $sql = "UPDATE KrAuftrag SET KopfNummer = $purchaseOrderNo WHERE ID = $result"
                $myConn.Execute($sql) | Out-Null
            } else {
                Throw ((Get-ResStr 'NUMBERSERIES_WITHOUT_RESULT') -f $myInvocation.Mycommand)
            }
        } else {
            Throw ((Get-ResStr 'NO_PURCHASEORDER_CREATED') -f $myInvocation.Mycommand)
        }
        <#
            # Actually we dont need that field
            $output = @{
                KopfId = $cmd.Parameters.Item("@KopfId").Value
                KopfNummer = $cmd.Parameters.Item("@KopfNummer").Value
            }
        #>
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: $id = New-PurchaseOrder -supplierID 15 -processedBy robot -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}
