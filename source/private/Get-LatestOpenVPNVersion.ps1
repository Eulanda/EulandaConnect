function Get-LatestOpenVPNVersion {
    [CmdletBinding()]
    param()

    $url = "https://openvpn.net/community-downloads/"
    $webPage = Invoke-WebRequest -Uri $url

    # Extract the version from the downloaded HTML
    $versionPattern = "(?<=OpenVPN-)\d+\.\d+\.\d+"
    $versions = $webPage.Content | Select-String -Pattern $versionPattern -AllMatches | ForEach-Object { $_.Matches.Value }

    # Sorting the versions and selecting the latest version
    $maxVersion = $versions | Sort-Object {[version]$_} -Descending | Select-Object -First 1
    return $maxVersion

   <# Test:

        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {
            Get-LatestOpenVPNVersion
        }

    #>
}
