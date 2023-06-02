function Get-MultipleOptions {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$values = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$list = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'list', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'item' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'newValues' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'value' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'valuesArray' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$newValues = ''

        if ($values) {
            [string[]]$valuesArray = $values.Split(',')
            foreach ($value in $valuesArray) {
                [int]$idx = $list.ToUpper().IndexOf($value.ToUpper())
                if ($idx -eq -1 ) { [string]$item = $list[0]
                } else { [string]$item = $list[$idx] }
                if ($newValues) {
                    $i = $newValues.ToUpper().IndexOf($item.ToUpper())
                    if ($i -eq -1) {
                        [string]$newValues +=  (',' + $item)
                    }
                } else { [string]$newValues = $Item }
            }
            $result = $newValues
        } else { [string]$result = $list[0] }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-MultipleOptions -values 'alpha,bravo,charlie' -list @('default','bravo','charlie','delta','echo')
}
