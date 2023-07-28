function Test-PropertyItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$id
        ,
        [Parameter(Mandatory = $false)]
        [ValidateRange("Positive")]
        [int]$propertyId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyId', $myInvocation.Mycommand))
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
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        Test-ValidateProperty -id $id -propertyId $propertyId -conn $myConn

        [bool]$result = $false

        [string]$sql = "SELECT Id From MerkmalElement WHERE KopfID = $propertyId AND ObjektID = $id"

        $rs = $Null
        $rs = $myConn.Execute($sql)
        if ($rs) {
            if (! $rs.eof) {
                $result = $true
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-PropertyItem -id 42 -propertyId 1358  -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
