Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DesktopDir' {

    It 'returns the correct desktop directory' {
        $expected = [Environment]::GetFolderPath("Desktop")
        Get-DesktopDir | Should -Be $expected
    }
}
