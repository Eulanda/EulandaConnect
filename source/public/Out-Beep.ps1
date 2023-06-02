function Out-Beep {
    [CmdletBinding()]
    param()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
    }

    process {
        [Console]::Beep()
    }

    end {
    }
    # Test: Out-Beep
}
