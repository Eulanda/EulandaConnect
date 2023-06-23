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

    foreach ($articleA in $datanorm.a.values) {
        # Start ARTIKEL
        $writer.WriteStartElement('ARTIKEL')

        $articleB = $datanorm.b[$articleA.ArtikelNummer]

        $cuSurchargePerUnit = [double](ConvertTo-USFloat($articleB.EUL_CuAufschlagProStueck))
        $pricePerUnit = [double](ConvertTo-USFloat -inputString ($articleA.EUL_PreisProStueck))
        $price = [math]::Round($pricePerUnit + $cuSurchargePerUnit, 2)
        $price = (ConvertTo-USFloat -inputString $price.ToString())

        $writer.WriteElementString('ARTNUMMER', $articleA.ArtikelNummer)
        $writer.WriteElementString('ARTMATCH', $articleB.Matchcode)
        $writer.WriteElementString('BARCODE', $articleB.EuroArtikelNummer)

        $writer.WriteElementString('ARTNUMMERERSATZ', $articleB.AlternativArtikelNummer)
        if ($articleA.PreisKennzeichen -eq '1') {
            $writer.WriteElementString('VKNETTO', $price)
        } else {
            $writer.WriteElementString('EKNETTO', $price)
        }
        $writer.WriteElementString('MENGENEH', $articleA.MengenEinheit)
        $writer.WriteElementString('VERPACKEH', $articleB.VerpackungsMenge)
        $writer.WriteElementString('RABATTGR', $articleA.RabattGruppe)
        $writer.WriteElementString('WARENGR', $articleA.WarenhauptGruppe)

        $writer.WriteElementString('KURZTEXT1', $articleA.Kurztext1)
        $writer.WriteElementString('KURZTEXT2', $articleA.Kurztext2)
        $writer.WriteElementString('ULTRAKURZTEXT', $articleA.Kurztext1)
        $writer.WriteElementString('LANGTEXT', "$($articleA.Kurztext1)`r`n$($articleA.Kurztext2)"  )

        # End ARTIKEL
        $writer.WriteEndElement()
    }

    # End ARTIKELLISTE
    $writer.WriteEndElement()
    $writer.WriteEndDocument()

    # Clean up the writer
    $writer.Flush()
    $writer.Close()

    # XML RAW for Root
    [xml]$xml = Get-XmlEulandaRoot

    # XML RAW for Metadata
    [xml]$xmlMetadata = Get-XmlEulandaMetadata

    # Now you have the XML in the StringWriter
    [xml]$xmlArticle = $stringWriter.ToString()

    $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
    $node = $xml.ImportNode($newNode, $true)
    $xml.DocumentElement.AppendChild($node) | Out-Null

    if ($xmlArticle) {
        $newNode = $xmlArticle.SelectSingleNode("//ARTIKELLISTE")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null
    }

    $result = [string](Format-Xml -xmlString $xml.OuterXml)

    Return $result
}
