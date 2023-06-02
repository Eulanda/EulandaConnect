function Get-ScriptDir {
    [CmdletBinding()]
    Param ()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'invocation' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (!(test-path variable:hostinvocation)) {$hostinvocation = $null}
        if ($null -ne $hostinvocation)
          { $result = (Split-Path $hostinvocation.MyCommand.path) }
        else
        {
            # scope 1 is the parent scope of the actual scope
            $invocation=(get-variable MyInvocation -Scope 1).Value
            if ($invocation.scriptname) {
                $result = (Split-Path $invocation.scriptname)
            }
        }
        if (-not (Test-Path $result)) { $result = $PSScriptRoot }
        if (-not (Test-Path $result)) { $result = (Get-Item -Path ".\" -Verbose).FullName}
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ScriptDir
}
