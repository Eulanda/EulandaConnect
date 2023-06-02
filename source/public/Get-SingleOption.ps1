function Get-SingleOption {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [parameter(Mandatory = $false)]
        [string[]]$list = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'list', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [int]$idx = $list.ToUpper().IndexOf($value.ToUpper())
        if ($idx -eq -1) {
            [string]$result = $list[0]
        } else {
          [string]$result = $list[$idx]
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-SingleOption -value 'alpha' -list @('default','bravo','charlie','delta','echo')
}
