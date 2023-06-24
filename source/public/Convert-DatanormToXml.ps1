function Convert-DatanormToXml {
    [CmdletBinding()]
    param(
        $datanorm
        ,
        [switch]$show
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Create XmlWriterSettings
        $settings = New-Object System.Xml.XmlWriterSettings
        $settings.Indent = $true

        # Create a StringWriter
        $stringWriter = New-Object System.IO.StringWriter

        # Create XmlWriter that writes to the StringWriter
        $writer = [System.Xml.XmlWriter]::Create($stringWriter, $settings)

        if ($show) {
            $totalItems = $datanorm.a.values.count + $datanorm.p.values.count
            $currentItem = 0
            $item = [string]""
        }

        $writer.WriteStartDocument()

        # Start ARTIKELLISTE
        $writer.WriteStartElement('ARTIKELLISTE')

        foreach ($articleA in $datanorm.a.values) {
            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                $item = $articleA.ArtikelNummer
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_DATANORM_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }

            # Start ARTIKEL
            $writer.WriteStartElement('ARTIKEL')

            $articleB = $datanorm.b[$articleA.ArtikelNummer]

            $writer.WriteElementString('ARTNUMMER', $articleA.ArtikelNummer)
            $writer.WriteElementString('ARTMATCH', $articleB.Matchcode)
            $writer.WriteElementString('BARCODE', $articleB.EuroArtikelNummer)
            $writer.WriteElementString('ARTNUMMERERSATZ', $articleB.AlternativArtikelNummer)


            $price = (ConvertTo-USFloat -inputString $articleA.Preis)
            if ($articleA.PreisKennzeichen -eq '1') {
                $writer.WriteElementString('VKNETTO', $price)
            } else {
                $writer.WriteElementString('EKNETTO', $price)
            }

            $writer.WriteElementString('PREISEH', (Get-DatanormPriceUnit -priceUnitCode $articleA.PreisEinheit ))
            $writer.WriteElementString('MENGENEH', $articleA.MengenEinheit)
            if ($articleB.VerpackungsMenge) {
                $writer.WriteElementString('VERPACKEH', $articleB.VerpackungsMenge)
            } else {
                $writer.WriteElementString('VERPACKEH', 1)
            }
            $writer.WriteElementString('RABATTGR', $articleA.RabattGruppe)
            $writer.WriteElementString('WARENGR', $articleA.WarenhauptGruppe)

            $writer.WriteElementString('KURZTEXT1', $articleA.Kurztext1)
            $writer.WriteElementString('KURZTEXT2', $articleA.Kurztext2)
            $writer.WriteElementString('ULTRAKURZTEXT', $articleA.Kurztext1)
            $writer.WriteElementString('LANGTEXT', "$($articleA.Kurztext1)`r`n$($articleA.Kurztext2)"  )

            $writer.WriteElementString('USERN3',  (ConvertTo-USFloat -inputString $articleB.EUL_CuAufschlagProStueck))

            # End ARTIKEL
            $writer.WriteEndElement()
        }


        foreach ($price in $datanorm.p.values) {
            # Start ARTIKEL
            $writer.WriteStartElement('ARTIKEL')

            $artNoSet = $false
            if ($price['1']) {
                $writer.WriteElementString('ARTNUMMER', $price['1'].ArtikelNummer)
                $item = $price['1'].ArtikelNummer
                $artNoSet = $true
                $writer.WriteElementString('VKNETTO', (ConvertTo-USFloat -inputString $price['1'].Preis))
            }

            if ($price['2']) {
                if (! $artNoSet) {
                    $writer.WriteElementString('ARTNUMMER', $price['2'].ArtikelNummer)
                    $item = $price['2'].ArtikelNummer
                }
                $writer.WriteElementString('EKNETTO', (ConvertTo-USFloat -inputString $price['2'].Preis))
            }

            # End ARTIKEL
            $writer.WriteEndElement()

            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_DATANORM_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }
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

        if ($show) {
            Write-Progress -Activity (Get-ResStr 'PROGBAR_DATANORM_PROMPT') -Completed
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  $xml = Convert-DatanormToXml -datanorm $datanorm
}
