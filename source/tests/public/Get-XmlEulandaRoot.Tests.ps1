Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-XmlEulandaRoot' -Tag 'eulanda' {

    It 'returns valid XML' {
        $result = Get-XmlEulandaRoot
        $result | Should -BeExactly "<EULANDA></EULANDA>"
    }
}
