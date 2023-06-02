function Get-IniBool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$section = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'section', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$variable = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'variable', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (test-path variable:global:ini) {
            [string]$test = $global:ini[$section][$variable]
            $result = Get-Bool -boolStr $test
        } else {
            $result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-IniBool -section 'Settings' -variable 'Name'
}
