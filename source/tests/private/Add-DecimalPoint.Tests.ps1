Import-Module -Name .\EulandaConnect.psd1

Describe 'Add-DecimalPoint' {
    InModuleScope EulandaConnect {

        It "Adds decimal points to an integer number" {
            $systemDecimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            $result = Add-DecimalPoint -number '10000' -decimalPlaces 2
            $expected = "100${systemDecimalSeparator}00"
            $result | Should -Be $expected
        }

        It "Adds decimal points to an integer number with more decimal places" {
            $systemDecimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            $result = Add-DecimalPoint -number '10000' -decimalPlaces 3
            $expected = "10${systemDecimalSeparator}000"
            $result | Should -Be $expected
        }

        It "Adds decimal points to an empty string" {
            $systemDecimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            $result = Add-DecimalPoint -number '' -decimalPlaces 2
            $expected = "0${systemDecimalSeparator}00"
            $result | Should -Be $expected
        }

        It "Prepends 0 to the number if the number of digits is less than the decimal places" {
            $systemDecimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            $result = Add-DecimalPoint -number '1' -decimalPlaces 2
            $expected = "0${systemDecimalSeparator}01"
            $result | Should -Be $expected
        }

        It "Appends 0 to the number if the number of digits is greater than the decimal places" {
            $systemDecimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            $result = Add-DecimalPoint -number '100' -decimalPlaces 2
            $expected = "1${systemDecimalSeparator}00"
            $result | Should -Be $expected
        }
    }
}
