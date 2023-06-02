function Get-ConnStr {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$database = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'database', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
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
        New-Variable -Name 'connItems' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (! ($server)) {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $connItems = Get-ConnItems -conn $myConn
            $server= $connItems['Data Source']
            $user= $connItems['User ID']
            $password= $connItems['Password']
        }

        if (($user) -and ($password)) {
            [string]$result = `
                "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;" +`
                "Persist Security Info=True;User ID=$user;Password=$password"
        } else {
            [string]$result = "Provider=SQLOLEDB.1;Data Source=$server;Initial Catalog=$database;Integrated Security=SSPI"
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ConnStr -udl 'C:\temp\Eulanda_1 Eulanda.udl' -database MyDatabase
}
