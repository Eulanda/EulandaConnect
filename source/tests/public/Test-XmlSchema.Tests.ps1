Import-Module -Name .\EulandaConnect.psd1

Describe 'Test-XmlSchema' {

    BeforeAll {
        $xmlFile = Join-Path -Path $env:TEMP -ChildPath "simple.xml"
        $schemaFile = Join-Path -Path $env:TEMP -ChildPath "simple.xsd"

        # XML content
        $xmlContent = @"
<EULANDA>
  <METADATA>
    <VERSION>5.20</VERSION>
  </METADATA>
</EULANDA>
"@

        # XSD content
        $xsdContent = @"
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="EULANDA">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="METADATA">
          <xs:complexType>
            <xs:sequence>
              <xs:element type="xs:decimal" name="VERSION"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>
"@

        # Create XML and XSD files
        Set-Content -Path $xmlFile -Value $xmlContent
        Set-Content -Path $schemaFile -Value $xsdContent
    }

    It "returns no error when the XML file matches the schema" {
        { Test-XmlSchema -xmlFile $xmlFile -schemaFile $schemaFile } | Should -Not -Throw
    }

    It "throws an error when the XML file does not match the schema" {
        # Modify the XML file to make it invalid
        (Get-Content -Path $xmlFile) -replace "5.20", "invalid" | Set-Content -Path $xmlFile
        { Test-XmlSchema -xmlFile $xmlFile -schemaFile $schemaFile } | Should -Throw
    }

    AfterAll {
        # Remove the XML and XSD files
        Remove-Item -Path $xmlFile -ErrorAction SilentlyContinue
        Remove-Item -Path $schemaFile -ErrorAction SilentlyContinue
    }
}
