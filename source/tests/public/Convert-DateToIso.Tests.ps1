Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-DateToIso' {

    It 'converts a datetime object to ISO format correctly with no option' {
        $result = [string](Convert-DateToIso -value (Get-Date "2023-07-10T10:30:00Z"))
        $result | Should -Be "2023-07-10T10:30:00.0+00:00"
    }


    It 'converts a datetime object to ISO format correctly with -asUtc option' {
        $result = Convert-DateToIso -value (Get-Date "2023-07-10T12:30:00") -asUtc
        $result | Should -Match (Get-Date "2023-07-10T12:30:00").ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    }


    It 'converts a datetime object to ISO format correctly with -noTime option' {
        $result = Convert-DateToIso -value (Get-Date "2023-07-10T12:30:00") -noTime
        $result | Should -Match "2023-07-10"
    }


    It 'converts a datetime object to ISO format correctly with -noDate option' {
        $result = Convert-DateToIso -value (Get-Date "2023-07-10T12:30:00") -noDate
        $result | Should -Match "12:30:00"
    }


    It 'converts a datetime object to ISO format correctly with -zeroTime option' {
        $result = Convert-DateToIso -value (Get-Date "2023-07-10T12:30:00Z") -zeroTime
        $result | Should -Be "2023-07-09T22:00:00.0+00:00"
    }


    It 'converts a datetime object to ISO format correctly with -noonTime option' {
        $result = Convert-DateToIso -value (Get-Date "2023-07-10T12:30:00Z") -noonTime
        $result | Should -Be "2023-07-10T10:00:00.0+00:00"
    }

}
