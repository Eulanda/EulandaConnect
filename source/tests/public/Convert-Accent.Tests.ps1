Import-Module .\EulandaConnect.psd1

Describe "Convert-Accent Tests" {

    It "Should replace special characters and convert to uppercase" {
        $value = 'Der Caffè ist übergut in Österreich!'
        $strCase = 'Upper'
        $result = Convert-Accent -value $value -strCase $strCase
        $expectedResult = 'DER CAFFE IST UEBERGUT IN OESTERREICH!'
        $result | Should -Be $expectedResult
    }

    It "Should replace special characters and convert to lowercase" {
        $value = 'Der Caffè ist übergut in Österreich!'
        $strCase = 'Lower'
        $result = Convert-Accent -value $value -strCase $strCase
        $expectedResult = 'der caffe ist uebergut in oesterreich!'
        $result | Should -Be $expectedResult
    }

    It "Should throw exception when mandatory parameters are missing" {
        { Convert-Accent } | Should -Throw
    }

}
