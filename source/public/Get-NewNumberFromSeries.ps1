function Get-NewNumberFromSeries {
    [CmdletBinding()]
    Param(
        [string]$seriesName
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
        New-Variable -Name 'adParamOutput' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'cmd' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'param1' -Scope 'Private' -Value ($null)
        New-Variable -Name 'param2' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

        # Configuring an ADODB.Command object
        $cmd = New-Object -comobject ADODB.Command
        $cmd.ActiveConnection = $myConn
        $cmd.CommandType = 4 # adCmdStoredProc
        $cmd.CommandText = "cn_NumGetNext"

        # ADODB.Parameter object for each parameter
        $param1 = $cmd.CreateParameter("@nr_Name", 200, 1, 50, $seriesName) # adVarWChar, adParamInput
        $cmd.Parameters.Append($param1)
        $adParamOutput = 2
        $param2 = $cmd.CreateParameter("@nr_NextNr", $adLockOptimistic, $adParamOutput, 0, 0) # adInteger, adParamOutput
        $cmd.Parameters.Append($param2)

        $cmd.Execute() | Out-Null
        $result = $cmd.Parameters.Item("@nr_NextNr").Value
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }

    # Test: $i = Get-NewNumberFromSeries -seriesName 'KrAuftrag' -udl 'C:\temp\EULANDA_1 JohnDoe.udl'
}