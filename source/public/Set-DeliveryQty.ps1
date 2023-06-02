function Set-DeliveryQty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({
            if($_.Count -lt 1) {
                throw (Get-ResStr 'STOCK_BOOKING_BATCH')
            }
            $true
        })]
        [array]$quantities = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'quantities', $myInvocation.Mycommand))
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
        [string]$bookingInfo
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
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryId) {
            [string]$sqlFrag = "@lf_id = $deliveryId,"
        } else {
            [string]$sqlFrag = "@KopfNummer = $deliveryNo,"
        }

        $xmlFrag = @(
            $quantities.foreach({
                "<UPDATE><ARTNUMMER>" + [Security.SecurityElement]::Escape($_.articleNo) + "</ARTNUMMER>" +
                "<MENGE>$($_.qty)</MENGE></UPDATE>"})
        );
        $xmlFrag = $xmlFrag -join "`r`n"

        $sql = @"
        set nocount on;
        declare @Updates xml = N'$xmlFrag';
        declare @exec int;

        exec @exec = dbo.cn_LfUpdateArFromXml
        $sqlFrag
        @Updates = @Updates,
        @xmlVersion = 1,
        @AfStornoRest = 1,
        @AfStornoGrund = '$bookingInfo'

        if @exec < 0 PRINT 'FEHLER'
"@
        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-DeliveryQty -quantities @(@{articleNo = '206003'; qty = 1}, @{articleNo = '206003'; qty = 5}) -deliveryNo 69 -bookingInfo 'Correction' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
