function Show-MsgBox {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$prompt = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'prompt', $myInvocation.Mycommand))
        ,
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateSet(0,1,2,3,4,5)]
        [int]$btn = $mbYesNo
        ,
        [Parameter(Position = 2, Mandatory = $false)]
        [string]$title = 'Info'
        ,
        [Parameter(Position = 3, Mandatory = $false)]
        [ValidateSet(0,16,32,48,64)]
        [int]$icon = $mbInfo
        ,
        [Parameter(Position = 4, Mandatory = $false)]
        [ValidateSet(0,256,512,768)]
        [int]$btnDef = $mbNone
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Add-Type -AssemblyName PresentationFramework | Out-Null
        [int]$result = [System.Windows.MessageBox]::Show((new-object System.Windows.Window -Property @{TopMost = $True}), $prompt, $title, $btn, $icon, $btnDef)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Show-MsgBox -prompt 'Do you want to continue?'
}
