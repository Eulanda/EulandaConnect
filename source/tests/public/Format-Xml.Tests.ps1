Import-Module -Name .\EulandaConnect.psd1

Describe 'Format-Xml' {

    BeforeAll {
        # Prepare a simple XML file for testing
        $testXml = @"
<Root>
    <Item />
</Root>
"@
        $testXmlFilePath = Join-Path $env:TEMP 'test.xml'
        Set-Content -Path $testXmlFilePath -Value $testXml

        # Expected output when formatting the XML
        $expectedFormattedXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<Root>
    <Item />
</Root>
"@
    }

    It 'formats XML from a string' {
        $formattedXml = Format-Xml -xmlString '<Root><Item /></Root>' -setDecoration
        $formattedXml | Should -Be $expectedFormattedXml.Trim()
    }

    It 'formats XML from a file' {
        $formattedXml = Format-Xml -pathIn $testXmlFilePath -setDecoration
        $formattedXml | Should -Be $expectedFormattedXml.Trim()
    }

    It 'throws an error when both xmlString and pathIn are provided' {
        { Format-Xml -xmlString '<Root><Item /></Root>' -pathIn $testXmlFilePath } | Should -Throw
    }

    It 'throws an error when neither xmlString nor pathIn are provided' {
        { Format-Xml } | Should -Throw
    }

    It 'throws an error when pathIn does not exist' {
        $nonExistentPath = Join-Path $env:TEMP 'non_existent.xml'
        { Format-Xml -pathIn $nonExistentPath } | Should -Throw
    }

    AfterAll {
        Remove-Item $testXmlFilePath
    }
}
