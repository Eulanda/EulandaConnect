function Import-ArticleFromXml {
    param(
        [string]$xml
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
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
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        if ($path) {
            [xml]$xml = Get-Content -Path $path
        } else {
            [xml]$xml = $xml
        }

        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $allowedProperties = @("ARTNUMMER", "EKNETTO", "VKNETTO", "VKBRUTTO", "BRUTTOFLG", "VK", "EK2NETTO")
        foreach($article in $xml.EULANDA.ARTIKELLISTE.ARTIKEL) {

            if ($article.PSObject.Properties.Name -contains "ARTNUMMER") {
                $articleNo = $article.ARTNUMMER
                $id = Get-ArticleId -articleNo $articleNo -conn $myConn
            } else {
                Write-Error "ArticleNo not present in xml!" -ErrorAction Continue
            }

            $articleChildNodes = $article.ChildNodes | Select-Object -ExpandProperty Name
            # Check if there are any properties that are not in the allowed list
            if ((@($articleChildNodes | Where-Object {$_ -notin $allowedProperties})).Count -gt 0) {
                $priceUpdate = $false
            } else {
                $priceUpdate = $true
            }

            if ($id) {
                # if we found an article we wont to update prices or an article
                $rs.Open("SELECT TOP 1 * FROM Artikel WHERE ID = $id", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
            } else  {
                if (! $priceUpdate) {
                    $rs.Open("SELECT TOP 0 * FROM Artikel", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
                    $rs.AddNew()
                    $rs.fields('ARTNUMMER').value = $articleNo
                } else {
                    # A price was found, but the article does not exist
                    # We do not want to insert an article with only one price
                    continue
                }
            }

            if ($article.PSObject.Properties.Name -contains 'ARTMATCH') {
                $rs.fields('ARTMATCH').value = $article.ARTMATCH
            }

            if ($article.PSObject.Properties.Name -contains 'LANGTEXT') {
                $rs.fields('LANGTEXT').value = $article.LANGTEXT
            }

            if ($article.PSObject.Properties.Name -contains 'KURZTEXT1') {
                $rs.fields('KURZTEXT1').value = $article.KURZTEXT1
            }

            if ($article.PSObject.Properties.Name -contains 'KURZTEXT2') {
                $rs.fields('KURZTEXT2').value = $article.KURZTEXT2
            }

            if ($article.PSObject.Properties.Name -contains 'ULTRAKURZTEXT') {
                $rs.fields('ULTRAKURZTEXT').value = $article.ULTRAKURZTEXT
            }

            if ($article.PSObject.Properties.Name -contains 'USERN3') {
                # used for copper surcharge
                $rs.fields('USERN3').value = $article.USERN3
            }

            if ($article.PSObject.Properties.Name -contains 'EKNETTO') {
                $rs.fields('EKNETTO').value = $article.EKNETTO
            }

            if ($article.PSObject.Properties.Name -contains 'EK2NETTO') {
                $rs.fields('EK2NETTO').value = $article.EK2NETTO
            }

            if (($article.PSObject.Properties.Name -contains 'VK') -and
                ($article.PSObject.Properties.Name -contains 'BRUTTOFLG')) {
                    $rs.fields('VK').value = $article.VK
                    $rs.fields('BruttoFlg').value = $article.BRUTTOFLG
            } elseif ($article.PSObject.Properties.Name -contains 'VKNETTO') {

                if ($rs.fields('EKNETTO').value -gt 0) {
                    # Only Datanorm uses UserNr3 für the copper surcharge per one unit
                    # If there is a PriceUnit higher then 1, then the copper surcharge must be multiplied with price units
                    $cuSurcharge = [float]($rs.fields('PREISEH').value * $rs.fields('USERN3').value)
                    $price = [float][math]::Round(([float]$article.VKNETTO + $cuSurcharge), 2)
                    $rs.fields('VK').value = [float]$price
                } else {
                    $rs.fields('VK').value = $article.VKNETTO
                }
                $rs.fields('BruttoFlg').value = 0
            } elseif ($article.PSObject.Properties.Name -contains 'VKBRUTTO') {
                $rs.fields('VK').value = $article.VKBRUTTO
                $rs.fields('BruttoFlg').value = 1
            }

            $rs.Update()
            $rs.Close()
        }
        $myConn.Close()
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
}
