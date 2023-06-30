Import-Module .\EulandaConnect.psd1

Describe 'Get-XmlEulandaRoot' {
    It 'returns valid XML' {
        $result = Get-XmlEulandaRoot
        $result | Should -BeExactly "<EULANDA></EULANDA>"
    }
}
