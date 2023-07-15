Import-Module -Name .\EulandaConnect.psd1

Describe "Get-SignToolPath" {
    It "Returns a valid SignTool path or throws an exception if not found" {
        try {
            # Invoke function
            $result = Get-SignToolPath

            # Check that the result is an existing file
            $result | Should -Exist
            Test-Path -Path $result -PathType Leaf | Should -Be $true
        }
        catch {
            # Check that the correct exception message is thrown
            $_.Exception.Message | Should -Match 'SIGNTOOL_NOT_FOUND'
        }
    }
}
