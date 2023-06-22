<#
.SYNOPSIS
Converts a Datanorm 4.0 file into a structured PowerShell object.

.DESCRIPTION
The function `Convert-FromDatanorm` reads a Datanorm file and converts it into a collection of PowerShell objects arranged in a hierarchical data structure. Currently, it can process the following types of records:
1. Type A: Basic Article Data - Includes basic information such as article number, description, price, unit, etc.
2. Type B: Additional Article Data - Includes supplementary details like alternative article number, weight, packaging amount, etc.
3. Type V: Version Data - Carries version information, date, and additional text information.
4. Type P: Price and Condition Data - Handles various price and condition information for an article.

The function is still under development. Future enhancements include handling long texts with insertions, bill of materials (BOM), and material surcharges. These additions will make the function more comprehensive and beneficial for processing Datanorm files.

.PARAMETER path
The path of the Datanorm file to be converted.

.PARAMETER mwSt
The value-added tax rate. The default value is 19.0.

.PARAMETER decimalSeparator
The decimal separator used in the Datanorm file. The default value is the current culture's number decimal separator.

.EXAMPLE
$datanorm = Convert-FromDatanorm -path "C:\Users\cn\Desktop\datanorm\Test\datanorm.001"

#>


function Convert-OemToUtf8 {
    param(
        [Parameter(Mandatory=$true)]
        [string]$inputString
    )

    $convertedString = [System.Text.StringBuilder]::new()

    foreach ($char in $inputString.ToCharArray()) {
        switch ([int][char]$char) {
            129 {
                $convertedString = $convertedString.Append('ü')
            }
            132 { $convertedString = $convertedString.Append('ä') }
            142 { $convertedString = $convertedString.Append('Ä') }
            148 { $convertedString = $convertedString.Append('ö') }
            153 { $convertedString = $convertedString.Append('Ö') }
            154 { $convertedString = $convertedString.Append('Ü') }
            225 { $convertedString = $convertedString.Append('ß') }
            default { $convertedString = $convertedString.Append($char) }
        }
    }

    return $convertedString.ToString()

    # Test: $a = Convert-OemToUtf8 'rc'
}


function ProcessCondition {
    param(
        [string]$condition,
        [int]$indicator
    )

    switch ($indicator) {
        0 { return $condition }
        1 { return $condition.Insert($condition.Length - 2, ",") }
        2 { return $condition.Insert($condition.Length - 3, ",") }
        3 { return $condition.Insert($condition.Length - 2, ",") }
        default { throw "Invalid condition indicator: $indicator" }
    }
}

function AddDecimalPoint {
    param(
        [string]$number,
        [int]$decimalPlaces = 2
    )

    # If the string is empty, return "0,00" (with two decimal places)
    if ([string]::IsNullOrEmpty($number)) {
        return "0," + "0" * $decimalPlaces
    }

    # If the number of digits is less than the decimalPlaces, prepend it with 0's
    while ($number.Length -lt $decimalPlaces) {
        $number = "0" + $number
    }

    # Insert the comma at the correct place
    $number = $number.Insert($number.Length - $decimalPlaces, ",")

    # If the number now starts with a comma, prepend it with a 0
    if ($number[0] -eq ",") {
        $number = "0" + $number
    }

    return $number
}

function Convert-DateFormat {
    param(
        [string]$date
    )

    # Ensure the date string is in the expected format
    if ($date -match '^(\d{2})(\d{2})(\d{2})$') {
        # Extract the day, month and year
        $day = $Matches[1]
        $month = $Matches[2]
        $year = $Matches[3]

        # Construct a new date string in the format "YYYY-MM-DD"
        # Here we assume the year is in the 2000s
        $newDate = "20$year-$month-$day"

        return $newDate
    } else {
        throw "Date string is not in the expected format: TTMMJJ"
    }
}


function Convert-FromDatanorm {
    param(
        [string]$path
        ,
        [double]$mwSt = 19.0
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
    )

    $encoding = [System.Text.Encoding]::GetEncoding("IBM850")  # IBM850 corresponds to CP850
    $allLines = [System.IO.File]::ReadAllLines($path, $encoding)

    # Create empty lists for each record type
    $a = @{}
    $b = @{}
    $v = @{}
    $p = @{}

    foreach ($line in $allLines) {
        # Check which record type is present and process accordingly
        if ($line[0] -eq "A") {
            # Separate individual fields
            $fields = $line.Split(";")

            # Create new PSobject and assign fields
            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen       = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]
                ArtikelNummer         = $fields[2]
                TextKennzeichen       = $fields[3]
                Kurztext1             = $fields[4]
                Kurztext2             = $fields[5]
                PreisKennzeichen      = $fields[6]
                PreisEinheit          = $fields[7]
                MengenEinheit         = $fields[8]
                Preis                 = AddDecimalPoint -number $fields[9]
                RabattGruppe          = $fields[10]
                WarenhauptGruppe      = $fields[11]
                LangtextSchluessel    = $fields[12]
            })
            $a[$rec.ArtikelNummer] = $rec
        }

        elseif ($line[0] -eq "B") {
            # Separate individual fields
            $fields = $line.Split(";")

            # Create new PSobject and assign fields
            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen          = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]
                ArtikelNummer            = $fields[2]
                Matchcode                = $fields[3]
                AlternativArtikelNummer  = $fields[4]
                KatalogSeite             = $fields[5]
                CUGewichtsMerker         = $fields[6]
                CUKennzahl               = $fields[7]
                Gewicht                  = AddDecimalPoint -number $fields[8]
                EuroArtikelNummer        = $fields[9]
                AnbindungsNummer         = $fields[10]
                WarenGruppe              = $fields[11]
                KostenArt                = $fields[12]
                VerpackungsMenge         = $fields[13]
                ReverenzKuerzel          = $fields[14]
                ReverenzNummer           = $fields[15]
            })
            $b[$rec.ArtikelNummer] = $rec
        }

        elseif ($line[0] -eq "V") {
            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen       = $line.Substring(0,1)
                Frei                  = $line.Substring(1,1)
                Datum                 = Convert-DateFormat $line.Substring(2,6)
                InfoText1             = $line.Substring(8,40).Trim()
                InfoText2             = $line.Substring(48,40).Trim()
                InfoText3             = $line.Substring(88,35).Trim()
                VersionsNummer        = $line.Substring(123,2)
                WaehrungsKennzeichen  = $line.Substring(125,3)
            })
            $v['V'] = $rec
        }

        elseif ($line[0] -eq "P") {
            $fields = $line.Split(";")

            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen          = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]

                ArtikelNummer           = $fields[2]
                PreisKennzeichen        = $fields[3]
                Preis                   = AddDecimalPoint -number $fields[4]
                KonditonKennzeichen1    = $fields[5]
                Kondition1              = ProcessCondition -condition $fields[6] -indicator ([int]$fields[5])
                KonditonKennzeichen2    = $fields[7]
                Kondition2              = ProcessCondition -condition $fields[8] -indicator ([int]$fields[7])
                KonditonKennzeichen3    = $fields[9]
                Kondition3              = ProcessCondition -condition $fields[10] -indicator ([int]$fields[9])
            })

            if ($rec.ArtikelNummer -ne '') {
                # Check if there's already an entry for the A article number
                if (!$p.ContainsKey($rec.ArtikelNummer)) {
                    # If not, create a new inner hash table for this article number
                    $p[$rec.ArtikelNummer] = @{}
                }
                # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
            }


            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen          = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]

                ArtikelNummer           = $fields[11]
                PreisKennzeichen        = $fields[12]
                Preis                   = AddDecimalPoint -number $fields[13]
                KonditonKennzeichen1    = $fields[14]
                Kondition1              = ProcessCondition -condition $fields[15] -indicator ([int]$fields[14])
                KonditonKennzeichen2    = $fields[16]
                Kondition2              = ProcessCondition -condition $fields[17] -indicator ([int]$fields[16])
                KonditonKennzeichen3    = $fields[18]
                Kondition3              = ProcessCondition -condition $fields[19] -indicator ([int]$fields[18])
            })

            if ($rec.ArtikelNummer -ne '') {
                # Check if there's already an entry for the A article number
                if (!$p.ContainsKey($rec.ArtikelNummer)) {
                    # If not, create a new inner hash table for this article number
                    $p[$rec.ArtikelNummer] = @{}
                }
                # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
            }

            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen          = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]

                ArtikelNummer           = $fields[20]
                PreisKennzeichen        = $fields[21]
                Preis                   = AddDecimalPoint -number $fields[22]
                KonditonKennzeichen1    = $fields[23]
                Kondition1              = ProcessCondition -condition $fields[24] -indicator ([int]$fields[23])
                KonditonKennzeichen2    = $fields[25]
                Kondition2              = ProcessCondition -condition $fields[26] -indicator ([int]$fields[25])
                KonditonKennzeichen3    = $fields[27]
                Kondition3              = ProcessCondition -condition $fields[28] -indicator ([int]$fields[27])
            })

            if ($rec.ArtikelNummer -ne '') {
                # Check if there's already an entry for the A article number
                if (!$p.ContainsKey($rec.ArtikelNummer)) {
                    # If not, create a new inner hash table for this article number
                    $p[$rec.ArtikelNummer] = @{}
                }
                # Now add the record to the inner hash table, using the PreisKennzeichen as the key
                $p[$rec.ArtikelNummer][$rec.PreisKennzeichen] = $rec
            }

        }
    }

    # Create a new object that contains all four record types
    $datanorm = New-Object PSObject -Property @{
        a = $a
        b = $b
        v = $v
        p = $p
    }

    return $datanorm
}


function Convert-ToEulanda {
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


$datanorm = Convert-FromDatanorm -path "C:\Users\cn\Desktop\datanorm\Test\datanorm.001"
$xml = Convert-ToEulanda -datanorm $datanorm
$xml


$datanorm.v
Write-Host "A-Record" -ForegroundColor Yellow
$datanorm.a
Write-Host "B-Record" -ForegroundColor Yellow
$datanorm.b
Write-Host "P-Record" -ForegroundColor Yellow
$datanorm.p
