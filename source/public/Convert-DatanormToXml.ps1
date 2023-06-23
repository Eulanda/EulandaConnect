function Convert-DatanormToXml {
    [CmdletBinding()]
    param(
        $datanorm
    )

    # Create XmlWriterSettings
    $settings = New-Object System.Xml.XmlWriterSettings
    $settings.Indent = $true

    # Create a StringWriter
    $stringWriter = New-Object System.IO.StringWriter

    # Create XmlWriter that writes to the StringWriter
    $writer = [System.Xml.XmlWriter]::Create($stringWriter, $settings)

    $writer.WriteStartDocument()

    # Start ARTIKELLISTE
    $writer.WriteStartElement('ARTIKELLISTE')

    foreach ($article in $datanorm.a.values) {
        # Start ARTIKEL
        $writer.WriteStartElement('ARTIKEL')

        $writer.WriteElementString('ARTNUMMER', $article.ArtikelNummer)
        $writer.WriteElementString('VK', $article.Preis)
        $writer.WriteElementString('KURZTEXT1', $article.Kurztext1)
        $writer.WriteElementString('KURZTEXT2', $article.Kurztext2)

        # End ARTIKEL
        $writer.WriteEndElement()
    }

    # End ARTIKELLISTE
    $writer.WriteEndElement()
    $writer.WriteEndDocument()

    # Clean up the writer
    $writer.Flush()
    $writer.Close()

    # Now you have the XML in the StringWriter
    $xml = $stringWriter.ToString()

    Return $xml
}
