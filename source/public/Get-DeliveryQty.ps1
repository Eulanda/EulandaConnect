function Get-DeliveryQty {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
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
        New-Variable -Name 'article' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'quantity' -Scope 'Private' -Value ([single]0.0)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        [string]$article = ""
        [float]$quantity = 0.0

        if (! $deliveryNo) {
            $deliveryNo = Get-DeliveryNo -deliveryId $deliveryId -conn $myConn
        }

        # The barcode is being misused here as an article no.
        [string]$sql = @"
        SELECT Art.Barcode [Article], lfp.Menge [Quantity] FROM LieferscheinPos [lfp]
        JOIN Lieferschein [lf] ON lfp.KopfId = lf.id
        JOIN Artikel [art] ON art.Id = lfp.ArtikelId
        WHERE lf.KopfNummer = $deliveryNo ORDER BY lfp.PosNummer
"@
        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
        if ($rs.eof) {
            throw ((Get-ResStr 'DELIVERYNO_NOT_EXISTS') -f $deliveryNo, $myInvocation.Mycommand)
        }
        while (! $rs.eof) {
            [string]$article = $rs.fields('Article').value
            [float]$quantity = $rs.fields('Quantity').value

            # Under certain circumstances, the delivery note may contain the same article several times
            if (! $result.ContainsKey($article)) {
                $result.Add($article, $quantity) | Out-Null
            } else {
                $result.Item($article) += $quantity
            }
            $rs.MoveNext() | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-DeliveryQty -deliveryId 28096 -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
