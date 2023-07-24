function Test-MssqlAdministrator {
    [CmdletBinding()]
    param (
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

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        if (! $conn) { $shouldClose = $true } else { $shouldClose = $false }
        $result = $false

        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if (($myConn) -and ($myConn.State -eq 1)) {
            $sql = "SELECT IS_SRVROLEMEMBER('sysadmin')"
            $rs = $myConn.Execute($sql)
            if ($rs.Fields.Item(0).Value -eq 1) {
                $result = $true
            }
            if ($shouldClose) {
                $myConn.Close()
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Test-MssqlAdministrator -udl '.\source\tests\Eulanda_1 Pester.udl'
}
