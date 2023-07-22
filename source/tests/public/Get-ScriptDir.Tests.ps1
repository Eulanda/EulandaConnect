Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-ScriptDir' {

    It "Returns a valid script directory" {
        # Invoke function
        $result = Get-ScriptDir

        # Check that the result is an existing directory
        $result | Should -Exist
        Test-Path -Path $result -PathType Container | Should -Be $true
    }
}
