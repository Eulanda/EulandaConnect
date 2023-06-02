function Open-Delivery {
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
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters
        $deliveryId = Get-DeliveryId @paramsDelivery -conn $myConn

        if ($deliveryId) {
            $sql = @"
                SET NOCOUNT ON;
                DECLARE @DeliveryId int
                SET @DeliveryId = $deliveryId
                EXEC dbo.cn_lfErfassen @lf_id=@DeliveryId
"@ }
        try {
            $myConn.Execute($sql) | out-null
        }

        catch {
            $relevantError = Get-ErrorFromConn -conn $myConn
            Throw "Error: $_! $relevantError"
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Open-Delivery -deliveryNo 69 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
