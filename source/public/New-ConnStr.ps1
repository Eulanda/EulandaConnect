function New-ConnStr {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$database = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'database', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$server = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'server', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string]$user
        ,
        [parameter(Mandatory = $false)]
        [string]$password
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
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
    # Test:  New-ConnStr -database 'EULANDA_Truccamo' -Server '.\SQL2019'
}
