function Get-LogName {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [string]$ident
        ,
        [parameter(Mandatory = $false)]
        [string]$dateMask = "yyyy-MM-dd--HH-mm-ss-fff"
    )
    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'datePart' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if (! $ident) {$ident = 'DEF'}

        [string]$datePart = Get-Date -date $ecStartTime -format $dateMask
        [string]$result = "LOG-$ident-$datePart.txt"
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-LogName -ident 'STANDARD'
}
