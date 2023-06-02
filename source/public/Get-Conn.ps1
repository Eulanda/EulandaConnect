function Get-Conn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'result' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($conn) {
            $result = $conn
            if ($result.state -eq $adStateClosed) {
                $result.open()
            }
        } elseif ($udl) {
            $result = Get-ConnFromUdl -udl $udl
        } elseif ($connStr) {
            $result = Get-ConnFromStr $connStr
        } else {
            throw ((Get-ResStr 'ADO_SET_ERROR') -f $($myInvocation.MyCommand))
        }

    } end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Conn -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
