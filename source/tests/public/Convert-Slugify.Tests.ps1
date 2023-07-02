Import-Module -Name .\EulandaConnect.psd1

Describe 'Convert-Slugify' {

    It "should correctly convert input string with default parameters" {
        $value = 'This is Österreich where you pan pay in € or $ but all in m³ and never in m²'
        $result = Convert-Slugify -value $value
        $result | Should -Be "This_is_Oesterreich_where_you_pan_pay_in_EUR_or_USD_but_all_in_m3_and_never_in_m2"
    }

    It "should correctly convert input string with '-' delimiter" {
        $value = 'This is Österreich where you pan pay in € or $ but all in m³ and never in m²'
        $result = Convert-Slugify -value $value -delimiter '-'
        $result | Should -Be "This-is-Oesterreich-where-you-pan-pay-in-EUR-or-USD-but-all-in-m3-and-never-in-m2"
    }

    It "should throw an error when no value is provided" {
        { Convert-Slugify } | Should -Throw
    }
}
