Import-Module -Name .\EulandaConnect.psd1

Describe 'ConvertTo-WrappedLinesEdi' {

    It "Test with normal text and width 40" {
        $text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.'
        $width = 40
        $expectedOutput = 'Lorem ipsum dolor sit amet, consectetur', 'adipiscing elit. Sed porttitor lacus ...'
        $output = ConvertTo-WrappedLinesEdi -text $text -width $width
        $output | Should -Be $expectedOutput
    }

    It "Test with long text and small width" {
        $text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed porttitor lacus sed augue commodo dapibus. Suspendisse potenti.'
        $width = 20
        $expectedOutput = 'Lorem ipsum dolor', 'sit amet, consect...'
        $output = ConvertTo-WrappedLinesEdi -text $text -width $width
        $output | Should -Be $expectedOutput
    }

    It "Test with small text and large width" {
        $text = 'Lorem ipsum'
        $width = 80
        $expectedOutput = 'Lorem ipsum', ''
        $output = ConvertTo-WrappedLinesEdi -text $text -width $width
        $output | Should -Be $expectedOutput
    }
}
