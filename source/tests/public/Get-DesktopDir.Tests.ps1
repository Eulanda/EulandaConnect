Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-DesktopDir' {
    It 'returns the correct desktop directory' {
        $expected = [Environment]::GetFolderPath("Desktop")
        Get-DesktopDir | Should -Be $expected
    }
}
