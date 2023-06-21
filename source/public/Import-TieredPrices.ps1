function Import-TieredPrices {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [Alias('barcode')]
        [string]$barcodeName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleNo')]
        [string]$articleNoName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleId')]
        [string]$articleIdName
        ,
        [Parameter(Mandatory = $false)]
        [Alias('articleUid')]
        [string]$articleUidName
        ,
        [Alias('price1')]
        [string]$price1Name
        ,
        [Alias('qty1')]
        [string]$qty1Name
        ,
        [Alias('price2')]
        [string]$price2Name
        ,
        [Alias('qty2')]
        [string]$qty2Name
        ,
        [Alias('price3')]
        [string]$price3Name
        ,
        [Alias('qty3')]
        [string]$qty3Name
        ,
        [Alias('price4')]
        [string]$price4Name
        ,
        [Alias('qty4')]
        [string]$qty4Name
        ,
        [Alias('price5')]
        [string]$price5Name
        ,
        [Alias('qty5')]
        [string]$qty5Name
        ,
        [string]$priceList
        ,
        [int]$priceListId
        ,
        [Alias('delim')]
        [string]$csvDelimiter = ';'
        ,
        [Alias('decimal')]
        [string]$decimalSeparator = [System.Globalization.CultureInfo]::CurrentCulture.NumberFormat.NumberDecimalSeparator
        ,
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams 'articleNoName','articleIdName','Barcode','articleUid' @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'row' -Scope 'Private' -Value ($null)
        New-Variable -Name 'qty' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'priceQtyPairs' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'price' -Scope 'Private' -Value ([double]0.0)
        New-Variable -Name 'pair' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'fileExtension' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'barcode' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'artId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'articleUid' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'articleNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'articleId' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
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

        $myConn = Get-Conn -udl $udl -connStr $connStr -conn $conn
        if ($priceList) {
            $rs = $myConn.execute("SELECT ID FROM Preisliste where [Name] = '$priceList'")
            [int]$priceListId = $rs.fields('ID').Value
        }

        if ($priceListId) {
            $fileExtension = [System.IO.Path]::GetExtension($path)
            switch ($fileExtension) {
                ".csv" {
                    $data = Import-Csv -Path $path -Delimiter $csvDelimiter
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

            if (! $decimalSeparator) {
                $decimalSeparator = ','
            }

            foreach ($row in $data) {
                $articleNo = [string]""
                $articleId = [int]0
                $barcode = [string]""
                $articleUid = [string]""

                $params = @{}
                if ($articleNoName) {
                    $articleNo = [string]$row.$($articleNoName)
                    $params.Add('articleNo', $articleNo)
                } elseif ($articleIdName) {
                    $articleId = [int]$row.$($articleIdName)
                    $params.Add('articleId', $articleId)
                } elseif ($BarcodeName) {
                    $barcode = [string]$row.$($barcodeName)
                    $params.Add('Barcode', $Barcode)
                } elseif ($articleUidName) {
                        $articleUid = [string]$row.$($articleUidName)
                        $params.Add('articleUid', $articleUid)
                } else {
                    Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f 'articleNoName, articleIdName, BarcodeName, articleUidName', $myInvocation.Mycommand)
                }

                $artId = Get-ArticleId @params -conn $myConn
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

                            # csv is string based excel normally double
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
                                Write-Verbose "ArticleNo: $articleNo"
                                $rs = New-Object -comobject ADODB.Recordset
                                $sql = "SELECT p.Id, p.Preisliste, p.Staffel, p.MengeAb, p.ArtikelId, p.Vk FROM Preis p " + `
                                "JOIN Artikel art ON art.Id = p.ArtikelId AND PreisListe = $priceListId AND art.ID = $artId " + `
                                "AND Staffel = $i"
                                $rs.Open($sql, $myConn, 3, 3)
                                if (! $rs.eof) {
                                    $rs.fields('Vk').value = [double]$price
                                    $rs.fields('MengeAb').value = [double]$qty
                                    $rs.update()
                                } else {
                                    $rs.AddNew()
                                    $rs.fields('Preisliste').value = $priceListId
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
                        } # if actual price
                    } # for each 1-5 tired price
                } # if article
            }  # for each row im import file
        }  else {
            Throw ((Get-ResStr 'PARAMS_AT_LEAST_ONE') -f 'priceList, priceListId', $myInvocation.Mycommand)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Import-TieredPrices -path 'C:\temp\test.xslx' -articleNo 'ArticleNo' -price1 'SalesPrice' -priceList 'Retail' -udl 'C:\temp\Eulanda_1 JohnDoe.udl'
}
