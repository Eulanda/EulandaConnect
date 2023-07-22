Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Install-SignTool' -Tag 'mock' {
    InModuleScope EulandaConnect {

        It 'should throw an exception if the download link is not found' {
            Mock Invoke-WebRequest -MockWith {
                return @{
                    Links = @()
                    Headers = @{}
                }
            }
            { Install-SignTool -url "https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/" } | Should -Throw -ExceptionType ([System.Management.Automation.RuntimeException])
        }
    }
}
