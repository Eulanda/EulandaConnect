Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-IpGeoInfo' -Tag 'integration', 'https' {

    BeforeAll {
        # Clear the global variable before running tests
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        $geoFile = "IpGeoInfoTest.xml"
        $geoPath = "$home\.eulandaconnect\$geoFile"
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
    }


    It "should return correct geoinfo for a public IP" {
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
        $ip = '8.8.8.8'  # Google DNS server IP
        $result = Get-IpGeoInfo -ip $ip -xmlGeoPath $geoFile
        $result | Should -Not -BeNullOrEmpty
        $result | Should -Not -Be '-1'
        $result | Should -Not -Be '-2'
        $result | Should -Not -Be '-3'
        $result | Should -Not -Be '-4'
    }


    It "should return -3 for private IP address" {
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
        $ip = '192.168.0.1'
        $result = Get-IpGeoInfo -ip $ip -xmlGeoPath $geoFile
        $result | Should -Be '-3'
    }


    It "should return -4 for reserved IP address" {
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
        $ip = '0.0.0.0'
        $result = Get-IpGeoInfo -ip $ip -xmlGeoPath $geoFile
        $result | Should -Be '-4'
    }


    It "should create a xmlGeoPath file in the given directory" {
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
        $ip = '8.8.8.8'
        Get-IpGeoInfo -ip $ip -xmlGeoPath $geoFile | Out-Null
        Test-Path $path | Should -BeTrue
        # Remove-Item $path  # Clean up
    }


    It "should give US for ip 8.8.8.8" {
        if (Test-Path variable:global:geoHashTable) {
            Remove-Variable -Name geoHashTable -Scope Global
        }
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
        $ip = '8.8.8.8'
        $result = Get-IpGeoInfo -ip $ip -xmlGeoPath $geoFile
        $result | Should -Be 'US'

    }


    AfterAll {
        if (Test-Path $geoPath) {
            Remove-Item $geoPath
        }
    }
}
