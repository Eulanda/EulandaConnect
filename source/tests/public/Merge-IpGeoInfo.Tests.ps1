Import-Module -Name .\EulandaConnect.psd1

Describe "Merge-IpGeoInfo" {
    It "Merges IP geolocation information correctly" {
        # Arrange
        $xmlFile1 = New-TemporaryFile
        $xmlFile2 = New-TemporaryFile
        $outputFile = New-TemporaryFile

        $ipGeoInfo1 = @{}
        $entry1 = New-Object PSObject -Property @{
            createDate = Get-Date
            changeDate = Get-Date
            data = @{
                countryCode = "US"
            }
        }
        $ipGeoInfo1['8.8.8.8'] = $entry

        $ipGeoInfo2 = @{}
        $entry2 = New-Object PSObject -Property @{
            createDate = Get-Date
            changeDate = Get-Date
            data = @{
                countryCode = "US"
            }
        }
        $ipGeoInfo2['8.8.4.4'] = $entry


        $ipGeoInfo1 | Export-Clixml -Path $xmlFile1.FullName
        $ipGeoInfo2 | Export-Clixml -Path $xmlFile2.FullName

        # Act
        Merge-IpGeoInfo -xmlFile1 $xmlFile1.FullName -xmlFile2 $xmlFile2.FullName -outputFile $outputFile.FullName

        # Assert
        $result = Import-Clixml -Path $outputFile.FullName
        $result.Keys.Count | Should -Be 2
        $result.ContainsKey("8.8.8.8") | Should -BeTrue
        $result.ContainsKey("8.8.4.4") | Should -BeTrue
    }
}

