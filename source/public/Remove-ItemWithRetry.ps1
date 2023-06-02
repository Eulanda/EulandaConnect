function Remove-ItemWithRetry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$path = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'path', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'retryCount' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'stopLoop' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $stopLoop = $false
        [int]$retryCount = "0"

        do {
            try {
                if (Test-Path $path) {
                    if ($path.ToUpper().IndexOf('\TEMP\')) {
                        Remove-Item -Path $path -Recurse -Force
                    } else {
                        Remove-Item -Path $path -Force
                    }
                }
                $stopLoop = $true
        } catch {
            if ($retryCount -gt 5) {
                Write-Host ((Get-ResStr 'REMOVE_FILE_ERROR') -f $($myInvocation.MyCommand), $path, $_) -foregroundcolor "red"
                $stopLoop = $true
                $Error.Clear()
        } else {
            $Error.Clear()
            Write-Verbose ((Get-ResStr 'REMOVE_FILE_RETRY') -f $path, $retryCount)
            Start-Sleep -Seconds 10
            $retryCount = $retryCount + 1
        } } }
        While ($stopLoop -eq $false)
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Remove-ItemWithRetry -path 'C:\temp\readme.txt'
}
