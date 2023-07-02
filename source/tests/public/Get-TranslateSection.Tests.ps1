Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-TranslateSection' {

    BeforeAll {
        $testText = "This is my default text, It is used when no language is found`r`n[EN]`r`nThe moon always has the same face`r`n[DE]`r`nDer Mond hat immer das selbe Gesicht`r`n[IT]`r`nLa luna ha sempre la stessa faccia"
    }

    It "should return the correct section for ISO and SUB inputs" {
        $result = Get-TranslateSection -text $testText -iso 'IT'
        $result | Should -Be "La luna ha sempre la stessa faccia"
    }

    It "should return the default text when no match for ISO and SUB inputs is found" {
        $result = Get-TranslateSection -text $testText -iso 'JP'
        $result | Should -Be "This is my default text, It is used when no language is found"
    }

    It "should return the subDefault when a match for ISO is found but no match for SUB" {
        $result = Get-TranslateSection -text $testText -iso 'IT' -sub 'TECH' -subDefault 'No specific tech details in Italian'
        $result | Should -Be "No specific tech details in Italian"
    }

    It "should throw an error when no ISO input is given" {
        { Get-TranslateSection -text $testText } | Should -Throw
    }
}
