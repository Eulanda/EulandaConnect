function Install-LatestOpenVPN {
    [CmdletBinding()]
    param(
        [string]$downloadPath = "$env:USERPROFILE\Downloads",
        [switch]$install,
        [switch]$full,
        [string]$openVpnMsi
    )

    if ($install -and (Test-OpenVPNInstalled)) {
        Write-Warning "OpenVPN is already installed."
        return
    }

    if ($openVpnMsi -and !(Test-Path -Path $openVpnMsi -PathType Leaf)) {
        throw "Invalid openVpnMsi path: $openVpnMsi"
    }

    $version = Get-LatestOpenVPNVersion
    $downloadUrl = "https://swupdate.openvpn.org/community/releases/OpenVPN-$($version)-I001-amd64.msi"
    $outputFilePath = Join-Path -Path $downloadPath -ChildPath "OpenVPN-$($version)-I001-amd64.msi"

    if (!$openVpnMsi) {
        $ProgressPreference = 'SilentlyContinue'
        $version = Get-LatestOpenVPNVersion
        $downloadUrl = "https://swupdate.openvpn.org/community/releases/OpenVPN-$($version)-I001-amd64.msi"
        $outputFilePath = Join-Path -Path $downloadPath -ChildPath "OpenVPN-$($version)-I001-amd64.msi"
        Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFilePath
        Write-Host "Downloaded: $outputFilePath"
        $openVpnMsi = $outputFilePath
    }



    if ($install) {
        $options = "OpenVPN.GUI,OpenVPN.Service,OpenVPN.Documentation,OpenVPN.SampleCfg,Drivers.OvpnDco,OpenVPN,OpenVPN.GUI.OnLogon,OpenVPN.PLAP.Register,Drivers,Drivers.TAPWindows6,Drivers.Wintun"
        if ($full) {
            $options += ",OpenSSL,EasyRSA"
        }
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$openVpnMsi`" ADDLOCAL=$options /passive" -NoNewWindow -Wait
    }
}
