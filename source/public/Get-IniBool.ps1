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

    <# Test:

        $pesterFolder = Resolve-Path -path ".\source\tests"
        $iniPath = Join-Path -path $pesterFolder "pester.ini"
        $ini = Read-IniFile -path $iniPath

        # Should be all true
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'TrueBool'
        # or
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'TrueOne'
        # or
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'TrueDollarBool'

        # Should be all false
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'FalseBool'
        # or
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'FalseZero'
        # or
        $testBool = Get-IniBool -section 'PESTERTEST' -variable 'FalseDollarBool'

        # General
        Get-IniBool -section 'Settings' -variable 'Name'

    #>
}
