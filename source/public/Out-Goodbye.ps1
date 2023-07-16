function Out-Goodbye {
    [CmdletBinding()]
    Param (
        [parameter(Mandatory = $false)]
        [switch]$normally
        ,
        [parameter(Mandatory = $false)]
        [switch]$abnormally
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'duration' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        New-Variable -Name 'ecEndTime' -Scope 'Global'  -Option ReadOnly -Force -Value ([datetime](Get-Date)) -Description 'End time of EulandaConnect module'
        $duration = New-Timespan -end $ecEndTime -start $ecStartTime
        write-host ((Get-ResStr 'OUT_WELCOME_STARTTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecStartTime.toString())})) -ForegroundColor Blue
        write-host ((Get-ResStr 'OUT_GOODBYE_ENDTIME') -f $(Use-Culture -culture $ecCulture -script {$($ecEndTime.toString())})) -ForegroundColor Blue
        Write-Host ((Get-ResStr 'OUT_GOODBYE_DURATION') -f $duration.TotalSeconds)  -ForegroundColor "blue"

        if ($normally) {
            Write-Host (Get-ResStr 'OUT_GOODBYE_NORMALLY') -ForegroundColor "blue"
            Write-Verbose (Get-ResStr 'OUT_GOODBYE_NORMALLY')  # For Pester test
        }
        if ($abnormally) {
            Write-Host (Get-ResStr 'OUT_GOODBYE_ABNORMALLY') -ForegroundColor "red"
            Write-Verbose (Get-ResStr 'OUT_GOODBYE_ABNORMALLY')  # For Pester test
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  Out-Goodbye -normally
}
