function Test-HasProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $inputVar = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'inputVar', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$propertyName = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'propertyName', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($propertyName) {
            if ($inputVar) {
                if ($null -ne $inputVar -and -not $inputVar.GetType().IsValueType) {
                    [bool]$result = ($propertyName -in $inputVar.PSobject.Properties.Name)
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        return $result
    }
    # Test:  Test-HasProperty -inputVar $error -propertyName 'Count'
}
