Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-XmlEulandaRoot' -Tag 'eulanda' {

    It 'returns valid XML' {
        $result = Get-XmlEulandaRoot
        $result | Should -BeExactly "<EULANDA></EULANDA>"
    }
}
