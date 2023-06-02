function Set-TrackingNo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [System.Array]$trackingNo = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'trackingNo', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
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
        New-Variable -Name 'carrierNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'oldUnits' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'oldValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'tempArray' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'tempStr' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($deliveryId) {
            [string]$sqlFrag = "Id = $deliveryId"
        } else {
            [string]$sqlFrag = "KopfNummer = $deliveryNo"
        }

        [string]$sql = "SELECT Id, KopfNummer [DeliveryNo], SpedAuftragNr [CarrierNo], TrackingNr [TrackingNo], " +`
                        "AnzahlPakete [Units], VersandDatum [ShippingDate] FROM Lieferschein WHERE $sqlFrag"

        $rs = $Null
        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
        if (! $rs.eof) {
            [string]$carrierNo = $rs.fields('CarrierNo').value
            # Only if this is the secoond document we have for this delivery note
            # be need to keep the old trackings also. This is indicated by an existing carrierNo.
            if ($carrierNo) {
                [string]$tempStr = $rs.fields('TrackingNo').value
                [int]$oldUnits = $rs.fields('Units').value
            } else {
                [string]$tempStr = ""
                [int]$oldUnits = 0
            }
            [string]$oldValue = $tempStr
            $tempStr = $tempStr.Replace("`r","").Trim()
            [System.Array]$tempArray = [System.Collections.ArrayList]::new()
            $tempArray = $tempStr.split("`n")
            $tempArray = $tempArray + $trackingNo
            $tempArray = $tempArray | Select-Object -Unique
            $tempArray = $tempArray | Sort-Object -Descending
            $tempStr = $tempArray -join "`r`n"
            $tempStr = $tempStr.Trim()
            $tempArray = $tempStr.Split("`r`n")
            # Avoid unnecessary change dates in the database
            if (($oldValue -ne $tempStr) -or ($oldUnits -ne $tempArray.count)) {
                $rs.fields('TrackingNo').value = $tempStr
                $rs.fields('Units').value = [int]$tempArray.count
                $rs.fields('ShippingDate').value = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                $rs.update()
            }
        } else {
            throw ((Get-ResStr 'DELIVERYNO_NOT_EXISTS') -f $deliveryNo, $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-TrackingNo -trackingNo @('4711','0815') -deliveryNo 69 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
