function Close-Delivery {
    [CmdletBinding()]
    param (
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
        New-Variable -Name "sql" -Scope "Private" -Value ""
        New-Variable -Name "myConn" -Scope "Private" -Value $null
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        if ($deliveryId)  {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @DeliveryId int
            SET @DeliveryId = $deliveryId
            EXEC dbo.cn_lfBuchen @lf_id=@DeliveryId
"@
        } else {
            $sql = @"
            SET NOCOUNT ON;
            DECLARE @DeliveryNo int
            SET @DeliveryNo = $deliveryNo
            EXEC dbo.cn_lfBuchen @lf_Nummer=@DeliveryNo
"@
        }

        $myConn.Execute($sql) | out-null

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:   Close-Delivery -deliveryNo 68 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
