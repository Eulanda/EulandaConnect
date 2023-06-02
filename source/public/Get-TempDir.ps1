function Get-TempDir {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = [System.IO.Path]::GetTempPath()
        if ($result.Substring($result.Length-1) -eq '\') {
            $result = $result.substring(0, $result.Length - 1)
        }
        if ($result -eq "\") { $result = "" }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-TempDir
}
