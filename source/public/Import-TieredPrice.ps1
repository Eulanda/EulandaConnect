function Import-TieredPrice {
    [CmdletBinding()]
    param(
        [string]$articleNoName
        ,
        [string]$price1Name
        ,
        [string]$qty1Name
        ,
        [string]$price2Name
        ,
        [string]$qty2Name
        ,
        [string]$price3Name
        ,
        [string]$qty3Name
        ,
        [string]$price4Name
        ,
        [string]$qty4Name
        ,
        [string]$price5Name
        ,
        [string]$qty5Name
        ,
        [string]$tierListName
        ,
        [string]$path
        ,
        [string]$udl
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)

        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        # Group values to a hash table
        $priceQtyPairs = @{
            "1" = @{ "price" = $price1Name; "qty" = $qty1Name }
            "2" = @{ "price" = $price2Name; "qty" = $qty2Name }
            "3" = @{ "price" = $price3Name; "qty" = $qty3Name }
            "4" = @{ "price" = $price4Name; "qty" = $qty4Name }
            "5" = @{ "price" = $price5Name; "qty" = $qty5Name }
        }

        $myConn = Get-Conn -udl $udl
        $rs = $myConn.execute("SELECT ID FROM Preisliste where [Name] = '$tierListname'")
        [int]$tierId = $rs.fields('ID').Value

        if ($tierId) {
            $fileExtension = [System.IO.Path]::GetExtension($path)
            switch ($fileExtension) {
                ".csv" {
                    $data = Import-Csv -Path $path -Delimiter ';'
                }

                ".xlsx" {
                    if ([bool](Get-Module -ListAvailable -Name ImportExcel)) {
                        Import-Module ImportExcel
                        $data = Import-Excel -Path $path
                    } else {
                        Throw ((Get-ResStr 'IMPORTEXCEL_NOTFOUND') -f $myInvocation.Mycommand)
                    }
                }

                default {
                    Throw ((Get-ResStr 'ONLY_CSV_AND_XSLX_SUPPORTED') -f $myInvocation.Mycommand)
                }
            }

            $decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
            if (! $decimalSeparator) {
                $decimalSeparator = ','
            }

            foreach ($row in $data) {
                $articleNo = [string]$row.$($articleNoName)
                $artId = Get-ArticleId -articleNo $articleNo -conn $myConn
                if ($artId) {
                    for ($i = 1; $i -le 5; $i++) {
                        $pair = $priceQtyPairs["$i"]
                        if (![string]::IsNullOrEmpty($pair['price']))  {
                            $price = $row.$($pair['price'])
                            if ([string]::IsNullOrEmpty($pair['qty'])) {
                                $qty = [string]"1"
                            } else {
                                $qty = [string]$row.$($pair['qty'])
                            }

                            if ($decimalSeparator -eq ".") {
                                if ($price.GetType.Name -eq 'String') {
                                    $price = [double]::Parse($price.Replace(',', '.'))
                                }

                                if ($qty.GetType.Name -eq 'String') {
                                    $qty = [double]::Parse($qty.Replace(',', '.'))
                                }
                            }
                            else {
                                if ($price.GetType.Name -eq 'String') {
                                    $price = [double]::Parse($price.Replace('.', ','))
                                }
                                if ($qty.GetType.Name -eq 'String') {
                                    $qty = [double]::Parse($qty.Replace('.', ','))
                                }
                            }

                            try {
                                Write-Verbose "ArticleNo: $artcicleNo"
                                $rs = New-Object -comobject ADODB.Recordset
                                $sql = "SELECT p.Id, p.Preisliste, p.Staffel, p.MengeAb, p.ArtikelId, p.Vk FROM Preis p " + `
                                "JOIN Artikel art ON art.Id = p.ArtikelId AND PreisListe = $tierId AND art.ID = $artId " + `
                                "AND Staffel = $i"
                                $rs.Open($sql, $myConn, 3, 3)
                                if (! $rs.eof) {
                                    $rs.fields('Vk').value = [double]$price
                                    $rs.fields('MengeAb').value = [double]$qty
                                    $rs.update()
                                } else {
                                    $rs.AddNew()
                                    $rs.fields('Preisliste').value = $tierId
                                    $rs.fields('Staffel').value = $i
                                    $rs.fields('ArtikelId').value = $artId
                                    $rs.fields('Vk').value = [double]$price
                                    $rs.fields('MengeAb').value = [double]$qty
                                    $rs.update()
                                }
                            }

                            catch {
                                Write-Error -Message $_.Exception -ErrorAction Continue
                            }

                        } # if price found
                    } # for each tired price
                } # if article found
            }  # for each row
        }  # tiered list found
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Import-TieredPrice -path 'C:\temp\test.xslx' -articleNoName 'ArticleNo' -price1Name 'SalesPrice' -tierListName 'Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}

