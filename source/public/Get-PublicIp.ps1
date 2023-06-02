function Get-PublicIp {
    [CmdletBinding()]
    Param ()

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = ""

        if (! $result) {
            try {
                $result = (Resolve-DnsName myip.opendns.com -Server resolver1.opendns.com -type A -ErrorAction SilentlyContinue).IPAddress
            }

            catch {
            }
        }

        if (! $result)  {
            try {
                $html = Invoke-RestMethod https://checkip.eurodyndns.org
                $lines = $html.split("`n")
                foreach ($line in $lines) {
                    $p = $Line.IndexOf("IP Address:")
                    if ($p -gt 0) {
                        $p = $line.IndexOf(":")
                        if ($p -gt 0) {
                            $result = $line.SubString($p +1).Trim()
                        }
                    }
                }
            }

            catch {
            }
        }

        if (! $result) {
            try {
                $result = Invoke-RestMethod https://ifconfig.me/ip
            }

            catch {
            }
        }

        if (! $result) {
            $result= '0.0.0.0'
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-PublicIp
}
