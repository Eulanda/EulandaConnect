function Get-DmsFolderSalesOrder {
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
        New-Variable -Name 'addressPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'match' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'salesOrderPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($salesOrderId) {
            [string]$sqlFrag = "so.Id = $salesOrderId"
        } elseif ($salesOrderNo) {
            [string]$sqlFrag = "so.KopfNummer = $salesOrderNo"
        } elseif ($customerOrderNo) {
            [string]$sqlFrag = "so.Bestellnummer = '$customerOrderNo'"
        } else {
            throw ((Get-ResStr 'SALESORDER_NOT_FOUND_PARAMETER') -f $($myInvocation.MyCommand))
        }

        [string]$sql = @"
            SELECT
                (SELECT radr.Match FROM Auftrag [so] JOIN Adresse [radr] ON so.AdresseId = radr.Id AND $sqlFrag) As [Match],
                (SELECT so.KopfNummer FROM Auftrag [so] JOIN Adresse [radr] ON so.AdresseId = radr.Id AND $sqlFrag) As [SalesOrderNo],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Adresse') WHERE Name = 'FolderPath') AS [AddressPath],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Auftrag') WHERE Name = 'FolderPath') AS [SalesOrderPath],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS') WHERE Name = 'BaseFolder') AS [BaseFolder]
"@

        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                $match = $rs.fields('Match').value
                $salesOrderNo = $rs.fields('SalesOrderNo').value
                $addressPath = $rs.fields('AddressPath').value
                $salesOrderPath = $rs.fields('SalesOrderPath').value
                $baseFolder = $rs.fields('BaseFolder').value
            }
        } else {
            throw ((Get-ResStr 'SALESORDER_NOT_FOUND_CONDITION') -f $sqlFrag, $($myInvocation.MyCommand))
        }
        [string]$result = "$baseFolder\$addressPath\$match\$salesOrderPath\$salesOrderNo"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DmsFolderSalesOrder -dmsBaseFolder 'C:\dms' -salesOrderNo 20230348 -udl 'C:\temp\Eulanda_1 Eulanda.udl' -debug
}
