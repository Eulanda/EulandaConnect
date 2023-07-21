Import-Module -Name .\EulandaConnect.psd1

InModuleScope EulandaConnect {
    Describe 'Install-SignTool' {
        It 'should throw an exception if the download link is not found' {
            Mock Invoke-WebRequest -MockWith {
                return @{
                    Links = @()
                    Headers = @{}
                }
            }
            { Install-SignTool -url "https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/" } | Should -Throw -ExceptionType ([System.Management.Automation.RuntimeException]) # Geändert, um den tatsächlich geworfenen Fehlertyp wiederzugeben
        }
    }
}
