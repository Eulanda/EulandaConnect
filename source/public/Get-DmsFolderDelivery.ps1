function Get-DmsFolderDelivery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$dmsBaseFolder = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'dmsBaseFolder', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
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
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'addressPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'deliveryPath' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'match' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryNo) {
            [string]$sqlFrag = "lf.KopfNummer = $deliveryNo"
        } else {
            [string]$sqlFrag = "lf.Id = $deliveryId"
        }

        [string]$match = ""
        [int]$deliveryNo = 0

        [string]$sql = @"
            SELECT
                (SELECT ladr.Match FROM Lieferschein [lf] JOIN Adresse [ladr] ON lf.AdresseId = ladr.Id AND $sqlFrag) AS [Match],
                (SELECT lf.KopfNummer FROM Lieferschein [lf] JOIN Adresse [ladr] ON lf.AdresseId = ladr.Id AND $sqlFrag) AS [DeliveryNo],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Adresse') WHERE Name = 'FolderPath') AS [AddressPath],
                (SELECT Valtext FROM cnf_RegValues('\VENDOR\esol\MODULES\DMS\DATAOBJECTS\Eulanda.Lieferschein') WHERE Name = 'FolderPath') AS [DeliveryPath]
"@

        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                $match = $rs.fields('Match').value
                $deliveryNo = $rs.fields('DeliveryNo').value
                $addressPath = $rs.fields('AddressPath').value
                $deliveryPath = $rs.fields('DeliveryPath').value
            }
        } else {
            throw ((Get-ResStr 'DELIVERYNOTE_NOT_FOUND_CONDITION') -f $sqlFrag, $myInvocation.Mycommand)
        }

        [string]$result = "$dmsBaseFolder\$addressPath\$match\$deliveryPath\$deliveryNo"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DmsFolderDelivery -dmsBaseFolder 'C:\dms' -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl' -debug
}
