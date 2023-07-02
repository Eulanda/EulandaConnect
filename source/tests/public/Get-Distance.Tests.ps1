Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-Distance' {

    It "Should return the correct distance between Berlin and Paris" {
        try {
            $result = Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522
            $result | Should -BeGreaterThan 870
            $result | Should -BeLessThan 890
        }
        catch {
            Write-Host "Exception: $_"
        }
    }

    It "Should throw exception when latitude or longitude parameters are not within correct range" {
        { Get-Distance -startLatitude 92 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -startLongitude 183 -endLatitude 48.8566 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 92 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 183 } | Should -Throw
    }

    It "Should throw exception when mandatory parameters are missing" {
        { Get-Distance -startLongitude 13.405 -endLatitude 48.8566 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -endLatitude 48.8566 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLongitude 2.3522 } | Should -Throw
        { Get-Distance -startLatitude 52.52 -startLongitude 13.405 -endLatitude 48.8566 } | Should -Throw
    }
}
