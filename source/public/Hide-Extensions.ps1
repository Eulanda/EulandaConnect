function Hide-Extensions {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        Push-Location
        Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
        if ((Get-ItemProperty .).HideFileExt -eq 0) {
            Set-ItemProperty . HideFileExt 1
            Start-Sleep -Milliseconds 500
            Update-Desktop
        }
        Pop-Location
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test:  Hide-Extensions
}
