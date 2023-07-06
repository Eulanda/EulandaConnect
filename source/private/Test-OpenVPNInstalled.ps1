function Test-OpenVPNInstalled {
    [CmdletBinding()]
    param()
    $openvpnExePath = 'C:\Program Files\OpenVPN\bin\openvpn.exe'
    return Test-Path -Path $openvpnExePath
}
