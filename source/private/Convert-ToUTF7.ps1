function Convert-ToUTF7 {
    Param(
        [Parameter(Mandatory = $false)]
        [string]$value = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'value', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($value)
        [string]$result = [System.Text.Encoding]::UTF7.GetString($bytes)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Convert-ToUTF7
}
