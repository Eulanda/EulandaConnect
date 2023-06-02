function Set-StockQty {
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
        [Parameter(Mandatory = $false)]
        [int]$stockGroup = 1
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
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlFrag' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        $xmlFrag = @(
            $quantities.foreach({
                "<item><ARTNUMMER>" + [Security.SecurityElement]::Escape($_.articleNo) + "</ARTNUMMER>" +
                "<MENGE>$($_.qty)</MENGE></item>"})
        );
        $xmlFrag = $xmlFrag -join "`r`n"

        $bookingInfo = if ($bookingInfo) {"'" + $bookingInfo.replace("'","''") + "'"} else {'null'};

        $sql = @"
        set nocount on;
        declare @x xml = N'$xmlFrag';

        select error from dbo.cnf_ExtractArMenge(@x,1) where error is not null;

        declare @Mengen [dbo].[TIdQtyTable], @ll_id int;

        insert @Mengen (id, quantity)
        select ArtikelId, Menge
        from dbo.cnf_ExtractArMenge(@x,0);

        exec dbo.cn_LL_SetBestandAbsolut
            @LagerGr = $stockGroup,
            @Mengen = @Mengen,
            @Objekt = $bookingInfo,
            @ll_id = @ll_id OUT;
"@

        $myConn.Execute($sql) | out-null
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Set-StockQty -quantities @(@{articleNo = '206003'; qty = 100}, @{articleNo = '206003'; qty = 500}) -bookingInfo 'Correction' -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
