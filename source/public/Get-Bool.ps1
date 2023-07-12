function Get-Bool {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$boolStr = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'boolStr', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $boolStr = $boolStr.ToUpper()
        if (($boolStr -eq "1") -or ($boolStr -eq "$TRUE") -or ($boolStr -eq '$TRUE') -or ($boolStr -eq "TRUE")) {
            [bool]$result = $true
        } else {
            [bool]$result = $false
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-Bool -boolStr 1
}
