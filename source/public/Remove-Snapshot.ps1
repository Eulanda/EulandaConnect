function Remove-Snapshot {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        $snapshot = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'snapshot', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'shadowId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'volume' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'symbolicLink' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (Test-Administrator) {
            [string]$shadowId = $snapshot.shadowID
            [string]$volume = $snapshot.volume
            [string]$symbolicLink = $snapshot.symbolicLink
            Remove-SymbolicLink -symbolicLink $symbolicLink
            [void](Invoke-Expression -command "cmd /c vssadmin delete shadows /Shadow='$shadowId' /Quiet")
        }  else {
            Throw ((Get-ResStr 'ADMIN_RIGHTS_NEEDED') -f $myInvocation.MyCommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-Snapshot -snapshot $snap
}
