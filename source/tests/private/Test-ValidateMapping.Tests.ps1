Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-ValidateMapping' {
    InModuleScope EulandaConnect {

        BeforeAll {
            # Definieren Sie das Mapping, das in den Tests verwendet wird
            $mapping = @{
                "a" = "1";
                "b" = "2";
                "c" = "3";
            }
        }

        It "Returns mapped value when key is passed" {
            $result = Test-ValidateMapping -strValue "a" -mapping $mapping
            $result | Should -Be "1"
        }

        It "Returns input value when it exists in the mapping values" {
            $result = Test-ValidateMapping -strValue "1" -mapping $mapping
            $result | Should -Be "1"
        }

        It "Throws an error when the value is not found in the mapping" {
            { Test-ValidateMapping -strValue "d" -mapping $mapping } | Should -Throw
        }
    }
}
