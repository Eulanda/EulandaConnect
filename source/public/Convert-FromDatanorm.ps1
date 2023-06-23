function Convert-FromDatanorm {
    [CmdletBinding()]
    param(
        [string]$path
        ,
        [double]$vat = 19.0
        ,
        [double]$cuDel = 879.0 # last official cuDel (Copper-DEL Notation) price 02/2022
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
    )

    if ((Get-Item $path).Length -eq 0) {
        throw "File $path is empty."
    }

    # First test utf-8, this is uncommon and also not according to the standard, but a good way to support both encodings
    $encoding = [System.Text.Encoding]::GetEncoding("UTF-8")
    $allLines = [System.IO.File]::ReadAllLines($path, $encoding)

    $hasInvalidChars = $false
    foreach($line in $allLines) {
        if ($line -match '�') {  # illegal char '�' found
            $hasInvalidChars = $true
            break
        }
    }

    if ($hasInvalidChars) {
        # This is the allowed method for datanorm
        $encoding = [System.Text.Encoding]::GetEncoding("IBM850")  # IBM850 corresponds to CP850
        $allLines = [System.IO.File]::ReadAllLines($path, $encoding)
    }


    # Create empty lists for each record type
    $a = @{}
    $b = @{}
    $v = @{}
    $p = @{}

    foreach ($line in $allLines) {
        # Check which record type is present and process accordingly

        # ------------------------------
        # TYPE A
        # ------------------------------
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
                Preis                 = Add-DecimalPoint -number $fields[9]
                RabattGruppe          = $fields[10]
                WarenhauptGruppe      = $fields[11]
                LangtextSchluessel    = $fields[12]
                EUL_PreisProStueck    = Get-DatanormPricePerUnit `
                                          -price (ConvertTo-USFloat(Add-DecimalPoint -number $fields[9])) `
                                          -priceUnitCode $fields[7]
            })
            $a[$rec.ArtikelNummer] = $rec
        }

        # ------------------------------
        # TYPE B
        # ------------------------------
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
                Gewicht                  = Add-DecimalPoint -number $fields[8]
                EuroArtikelNummer        = $fields[9]
                AnbindungsNummer         = $fields[10]
                WarenGruppe              = $fields[11]
                KostenArt                = $fields[12]
                VerpackungsMenge         = $fields[13]
                ReverenzKuerzel          = $fields[14]
                ReverenzNummer           = $fields[15]
                EUL_CuGewichtProStueck   = Get-DatanormCuWeight `
                                            -cuWeight (ConvertTo-USFloat(Add-DecimalPoint -number $fields[8])) `
                                            -divisionCode $fields[6]
                EUL_CuAufschlagProStueck = Get-DatanormCuSurcharge `
                                            -cuWeight (ConvertTo-USFloat(Add-DecimalPoint -number $fields[8])) `
                                            -cuDel $cuDel `
                                            -cuIncluded $fields[7] `
                                            -divisionCode $fields[6]
                EUL_CuDelPro100Kg        = $CuDel.ToString()
            })
            $b[$rec.ArtikelNummer] = $rec
        }


        # ------------------------------
        # TYPE V
        # ------------------------------
        elseif ($line[0] -eq "V") {
            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen       = $line.Substring(0,1)
                Frei                  = $line.Substring(1,1)
                Datum                 = Convert-DatanormDateFormat $line.Substring(2,6)
                InfoText1             = $line.Substring(8,40).Trim()
                InfoText2             = $line.Substring(48,40).Trim()
                InfoText3             = $line.Substring(88,35).Trim()
                VersionsNummer        = $line.Substring(123,2)
                WaehrungsKennzeichen  = $line.Substring(125,3)
            })
            $v['V'] = $rec
        }


        # ------------------------------
        # TYPE P
        # ------------------------------
        elseif ($line[0] -eq "P") {
            $fields = $line.Split(";")

            $rec = New-Object PSObject -Property ([ordered]@{
                SatzKennzeichen          = $fields[0]
                VerarbeitungsKennzeichen = $fields[1]

                ArtikelNummer           = $fields[2]
                PreisKennzeichen        = $fields[3]
                Preis                   = Add-DecimalPoint -number $fields[4]
                KonditonKennzeichen1    = $fields[5]
                Kondition1              = Get-DatanormConditionDecimals -condition $fields[6] -indicator ([int]$fields[5])
                KonditonKennzeichen2    = $fields[7]
                Kondition2              = Get-DatanormConditionDecimals -condition $fields[8] -indicator ([int]$fields[7])
                KonditonKennzeichen3    = $fields[9]
                Kondition3              = Get-DatanormConditionDecimals -condition $fields[10] -indicator ([int]$fields[9])
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
                Preis                   = Add-DecimalPoint -number $fields[13]
                KonditonKennzeichen1    = $fields[14]
                Kondition1              = Get-DatanormConditionDecimals -condition $fields[15] -indicator ([int]$fields[14])
                KonditonKennzeichen2    = $fields[16]
                Kondition2              = Get-DatanormConditionDecimals -condition $fields[17] -indicator ([int]$fields[16])
                KonditonKennzeichen3    = $fields[18]
                Kondition3              = Get-DatanormConditionDecimals -condition $fields[19] -indicator ([int]$fields[18])
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
                Preis                   = Add-DecimalPoint -number $fields[22]
                KonditonKennzeichen1    = $fields[23]
                Kondition1              = Get-DatanormConditionDecimals -condition $fields[24] -indicator ([int]$fields[23])
                KonditonKennzeichen2    = $fields[25]
                Kondition2              = Get-DatanormConditionDecimals -condition $fields[26] -indicator ([int]$fields[25])
                KonditonKennzeichen3    = $fields[27]
                Kondition3              = Get-DatanormConditionDecimals -condition $fields[28] -indicator ([int]$fields[27])
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
