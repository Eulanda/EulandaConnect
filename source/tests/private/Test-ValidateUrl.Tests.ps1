Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-ValidateUrl' -Tag 'http' {
    InModuleScope EulandaConnect {

        # Arrange
        $testCases = @(
            @{ Url = "https://www.google.com"; IsValid = $true },
            @{ Url = "http://www.google.com/service/Products?filter=Name%20ge%20%27Milk%27"; IsValid = $true },
            @{ Url = "http://www.google.com"; IsValid = $true },

            @{ Url = "ftp://ftp.google.com"; IsValid = $false },
            @{ Url = "www.google.com"; IsValid = $false },
            @{ Url = "ftp://www.google.com"; IsValid = $false },
            @{ Url = ""; IsValid = $false }
        )

        It "validates URL '<url>' correctly" -TestCases $testCases {
            param ($Url, $IsValid)

            if ($IsValid) {
                { Test-ValidateUrl -url $Url } | Should -Not -Throw
            } else {
                { Test-ValidateUrl -url $Url } | Should -Throw
            }
        }
    }
}
