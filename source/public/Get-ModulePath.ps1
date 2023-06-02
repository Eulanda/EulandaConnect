function Get-ModulePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$module = 'EulandaConnect'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = ((Get-Module -Name $module).ModuleBase)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-ModulePath
}
