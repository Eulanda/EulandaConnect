function Get-OldestFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'entry' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $entry = Get-ChildItem -Path $path | Sort-Object -Property LastWriteTime | select-object -First 1
        if ($entry) {
            [string]$result = $entry.Name
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-OldestFile -path 'C:\temp'
}
