Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-Path32' {

    It "Returns the correct path for 32-bit program files" {

        # Store the expected result based on the system architecture
        $expectedResult = If ($env:PROCESSOR_ARCHITECTURE -eq "x86") {
            $env:PROGRAMFILES
        } else {
            ${env:PROGRAMFILES(x86)}
        }

        # Invoke the function and store the result
        $result = Get-Path32

        # Check that the result matches the expected value
        $result | Should -Be $expectedResult
    }
}
