function Test-Numeric() {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$value,

        [parameter(Mandatory = $false)]
        [switch]$allowZero
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'Matches' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [bool]$result = $value -match "^[\d\.]+$"
        if (! $allowZero) {
            if ($result) {
                $value = $value.replace('0','')
                if (! $value) { $result = $false }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:   Test-Numeric -value '45x'
}
