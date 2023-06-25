Import-Module .\EulandaConnect.psd1

Describe "Read-IniFile Tests" {

    BeforeAll {
        $testIniContent = @"
[Section1]
Key1=Value1
Key2=Value2

[Section2]
Key1=Value3
Key2=Value4
"@

        $testIniFilePath = Join-Path $TestDrive "Test.ini"
        Set-Content -Path $testIniFilePath -Value $testIniContent
    }

    It "Returns the correct values for the test INI file" {
        $result = Read-IniFile -Path $testIniFilePath

        $result["Section1"]["Key1"] | Should -Be "Value1"
        $result["Section1"]["Key2"] | Should -Be "Value2"
        $result["Section2"]["Key1"] | Should -Be "Value3"
        $result["Section2"]["Key2"] | Should -Be "Value4"
    }

    It "Case insensitive section and key names" {
        $result = Read-IniFile -Path $testIniFilePath

        $result["section1"]["key1"] | Should -Be "Value1"
        $result["SECTION1"]["KEY1"] | Should -Be "Value1"
        $result["sEcTiOn1"]["KeY1"] | Should -Be "Value1"
    }

    It "Does not return a non-existing section" {
        $result = Read-IniFile -Path $testIniFilePath

        $result["NonExistingSection"] | Should -BeNullOrEmpty
    }

    It "Throws an error when the INI file does not exist" {
        { Read-IniFile -Path "NonExistingFile.ini" } | Should -Throw
    }

    AfterAll {
        Remove-Item -Path $testIniFilePath -ErrorAction SilentlyContinue
    }
}
