Function New-OpenVpnServerConfig {
    [CmdletBinding()]
    param(
        [string]$openVpnPath = "$($env:ProgramFiles)\OpenVPN"
        ,
        [string]$destination = "$($home)\.eulandaconnect\OpenVPN"
        ,
        [string]$hostname = [System.Net.Dns]::GetHostname()
        ,
        [string]$networkAddress = '192.168.40.0'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $openVpnConfigPath = Join-Path -path $openVpnPath "sample-config\server.ovpn"
        [string[]]$lines = Get-Content $openVpnConfigPath
        [System.Collections.ArrayList]$outLines = @()
        foreach ($line in $lines) {
            if ($line -match "^ca ") {
                $outlines.Add("ca `"ca.crt`"") | out-null
            } elseif ($line -match "^cert ") {
                $outlines.Add("cert `"$hostname.crt`"") | out-null
            } elseif ($line -match "^key ") {
                $outlines.Add("key `"$hostname.key`"  # This file should be kept secret") | out-null
            } elseif ($line -match "^dh ") {
                $outlines.Add("dh `"dh2048.pem`"") | out-null
            } elseif ($line -match "^server ") {
                $outlines.Add("server $networkAddress 255.255.255.0") | out-null
            } else {
                $outlines.Add($line) | out-null
            }
        }

        $openVpnConfigPath = Join-Path -path $destination "server\$hostname.ovpn"

        $folderPath = Split-Path -Path $openVpnConfigPath -Parent
        if (-not (Test-Path $folderPath -PathType Container)) {
            New-Item -ItemType Directory -Path $folderPath | Out-Null
        }

        [array]$outlines = $outlines -Join "`r`n"
        [IO.File]::WriteAllText($openVpnConfigPath, $outlines, [System.Text.Encoding]::Utf8)

        ConvertTo-UnixLineEndingsFile $openVpnConfigPath
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }

    <#

        New-OpenVpnServerConfig -networkAddress = '192.168.42.0' -hostname MYSERVER

    #>
}
