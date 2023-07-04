function New-OpenVpnTls {
    [CmdletBinding()]
    param(
        [string]$openVpnPath = "$($env:ProgramFiles)\OpenVPN"
        ,
        [string]$destination = "$($home)\.eulandaconnect\OpenVPN"
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $requiredVersion = "2.5"
        $exePath = Join-Path -Path $openVpnPath -ChildPath "bin\openvpn.exe"
        $keyPath = Join-Path -Path $destination -ChildPath "tls\ta.key"

        if (! (Test-Path $keyPath)) {
            if (Test-Path $exePath) {
                if ([version](Get-Item $exePath).VersionInfo.FileVersion -gt [version]$requiredVersion) {
                    $arguments = "--genkey secret `"$keyPath`""
                } else {
                    $arguments = "--genkey --secret `"$keyPath`""
                }

                $folderPath = Split-Path -Path $keyPath -Parent
                if (-not (Test-Path $folderPath -PathType Container)) {
                    New-Item -ItemType Directory -Path $folderPath | Out-Null
                }

                $psi = New-Object System.Diagnostics.ProcessStartInfo
                $psi.FileName = $exePath
                $psi.WorkingDirectory = (Join-Path -Path $openVpnPath 'bin')
                $psi.Arguments = $arguments
                $psi.CreateNoWindow = $true
                $psi.UseShellExecute = $false
                $psi.RedirectStandardError = $true

                $process = Start-Process -Wait -PassThru -NoNewWindow -FilePath $psi.FileName -ArgumentList $psi.Arguments

                if ($process.ExitCode -ne 0) {
                    $errorMessage = $process.StandardError.ReadToEnd()
                    Write-Error ( Get-ResStr('ERROR_OPENVPN_ON_TLS_CREATION') -f $process.ExitCode, $errorMessage, $myInvocation.Mycommand) -ErrorAction stop
                }
            } else { Write-Error ( Get-ResStr('OPENVPN_NOT_FOUND') -f $openVpnPath, $myInvocation.Mycommand) -ErrorAction Stop }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }

    <# Test:

           New-OpenVpnTls

    #>
}
