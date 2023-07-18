Import-Module -Name .\EulandaConnect.psd1

Describe "Test-ValidateSingle" {
    InModuleScope 'EulandaConnect' {

        It "Throws an error when more than one valid parameter is provided" {
            {
                function Test-Function {
                    [CmdletBinding()]
                    param (
                        [string]$param1,
                        [string]$param2,
                        [string]$param3
                    )
                    Test-ValidateSingle -validParams @('param1', 'param2', 'param3') -remainingArguments $PSBoundParameters
                }
                Test-Function -param1 "Test" -param2 "Test"
            } | Should -Throw
        }

        It "Throws an error when no valid parameter is provided" {
            {
                function Test-Function {
                    [CmdletBinding()]
                    param (
                        [string]$param1,
                        [string]$param2,
                        [string]$param3
                    )
                    Test-ValidateSingle -validParams @('param1', 'param2', 'param3') -remainingArguments $PSBoundParameters
                }
                Test-Function
            } | Should -Throw
        }
    }
}
