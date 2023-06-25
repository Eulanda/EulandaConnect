function Test-Console {
    [CmdletBinding()]
    param( )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'hasRdpSession' -Scope 'Private' -Value ([boolean]$false)
        New-Variable -Name 'sessionList' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        <#
            # Deprecated, only for information
            [string]$str = quser.exe | Select-String -Quiet '\brdp-'
            if ($str -eq 'True') {[boolean]$result = $false} else { [boolean]$result = $true }
        #>

        $sessionList = Get-CimInstance -ClassName Win32_LogonSession
        $hasRdpSession = $sessionList.LogonType -contains 10 # 10 corresponds to RDP sessions in Win32_LogonSession class

        if ($hasRdpSession) {
            $result = $false
        } else {
            $result = $true
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Test-Console
}
