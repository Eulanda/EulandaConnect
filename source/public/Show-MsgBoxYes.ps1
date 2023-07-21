function Show-MsgBoxYes {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$prompt = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'prompt', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'answer' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($env:PESTER_TEST_RUN -eq "1") {
            throw "Test environment detected, aborting Show-MsgBoxYes"
        }

        [int]$answer = Show-MsgBox -prompt $prompt -title 'Info' -icon $mbNone -btnDef $mbNone
        if ($answer -eq $mbrYes) {
            [bool]$result = $true
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Show-MsgBoxYes -prompt 'Do you want more?'
}
