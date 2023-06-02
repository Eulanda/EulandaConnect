function New-Shortcut {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$file = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'file', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$link = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'link', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'shortcut' -Scope 'Private' -Value ($null)
        New-Variable -Name 'wshShell' -Scope 'Private' -Value ($null)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            if (! (Test-Path $link)) {
                if (Test-Path $file) {
                    $wshShell = New-Object -comObject WScript.Shell
                    $shortcut = $wshShell.CreateShortcut($link)
                    $shortcut.TargetPath = $file
                    $shortcut.Save()
                } else {
                    throw ((Get-ResStr 'NO_FILE_FOR_SHORTCUT') -f $file, $($myInvocation.MyCommand))
                }
            }
        }

        catch {
            if ($ErrorActionPreference -eq "SilentlyContinue") {
                # do nothing
            } elseif ($ErrorActionPreference -eq "Stop") {
                throw $_.Exception.Message
            } else {
                Write-Host $_.Exception.Message -ForegroundColor Red
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
    }
    # Test:  New-Shortcut -file 'C:\Temp\eulanda.exe' -link "$(Get-DesktopDir)\MyEulanda.lnk -ErrorAction Continue"
}
