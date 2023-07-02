Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-XmlEulandaMetadata' {

    It 'returns valid XML with USERNAME and PCNAME when no switch is set' {
        $result = Get-XmlEulandaMetadata
        $result | Should -Match "<USERNAME>"
        $result | Should -Match "<PCNAME>"
    }

    It 'returns valid XML without USERNAME when -noUsername switch is set' {
        $result = Get-XmlEulandaMetadata -noUsername
        $result | Should -Match "<PCNAME>"
        $result | Should -Not -Match "<USERNAME>"
    }

    It 'returns valid XML without PCNAME when -noPcName switch is set' {
        $result = Get-XmlEulandaMetadata -noPcName
        $result | Should -Match "<USERNAME>"
        $result | Should -Not -Match "<PCNAME>"
    }

    It 'returns valid XML without USERNAME and PCNAME when both switches are set' {
        $result = Get-XmlEulandaMetadata -noUsername -noPcName
        $result | Should -Not -Match "<USERNAME>"
        $result | Should -Not -Match "<PCNAME>"
    }
}
