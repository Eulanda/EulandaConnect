function Get-AddressId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$addressMatch
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$addressId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$addressUid
        ,
        [Parameter(Mandatory = $false)]
        [switch]$like
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
        WWrite-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleAddressKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'firstEntry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'key' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsAddress' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlFrag' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $paramsAddress = Get-UsedParameters -validParams (Get-SingleAddressKeys) -boundParams $PSBoundParameters
            $firstEntry = $paramsAddress.GetEnumerator() | Select-Object -First 1
            $key = Test-ValidateMapping -strValue ($firstEntry.Key) -mapping (Get-MappingAddressKeys)
            $value = $firstEntry.Value

            if ($like) {
                $sqlFrag = "$key like '$value%'"
            } else {
                $sqlFrag = "$key = '$value'"
            }

            [string]$sql = "SELECT Id FROM Adresse WHERE $sqlFrag"
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                [int]$result = $rs.fields('Id').Value
                if ($rs.RecordCount -gt 1) {
                    throw ((Get-ResStr 'MULTIPLE_RESULTS_FOUND_ERROR') -f $sqlFrag, $($myInvocation.MyCommand))
                }
            }
        }

        catch {
            Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-AddressId -addressUid '{E05050A1-501F-462B-A2E2-FD27F7F52382}' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
