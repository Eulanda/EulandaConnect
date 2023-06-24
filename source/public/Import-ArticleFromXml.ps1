function Import-ArticleFromXml {
    param(
        [string]$xml
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [switch]$cuSurcharge
        ,
        [switch]$show
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

        # ------------------------------------------------
        # HANDLE READONLY FIELDS
        # ------------------------------------------------
        $readOnlyFields = Get-ReadOnlyFields -conn $myConn -tablename 'Artikel'

        # We dont support these field in this moment
        $readOnlyFields += 'BasisArtikelId', 'ChargenPflichtFlg', 'HauptLieferantID', 'HerstellerID', `
            'IdentTyp', 'KasseVorfallTyp', 'LangtextRevision', 'Locked', 'LoeschFlg', 'Multi', 'MwStGr', `
            'MwstSatz', 'ProduktManagerId', 'Revision', 'SNPflichtFlg', 'Sperre_Lager', 'Stamp', `
            'StatistikArtikelId', 'StatistikFlg', 'Status', 'StkLstProdFlg', 'StueckMulti', 'Typ', `
            'VarianteFlg', 'VarianteHauptArtikelId', 'VarianteHauptFlg', 'VertreterID'

        # We are making special handlings with these price fields
        $readOnlyFields = $readOnlyFields | Where-Object { $_ -ne "VKNETTO" -and $_ -ne "VKBRUTTO" }

        $readOnlyFields = $readOnlyFields | Select-Object -Unique

        # ------------------------------------------------
        # HANDLE OTHER STUFF
        # ------------------------------------------------

        # If only this fields are in an XML then it is a pricelist update
        $pricelistProperties = @("ARTNUMMER", "EKNETTO", "VKNETTO", "VKBRUTTO", "BRUTTOFLG", "VK", "EK2NETTO")


        # ------------------------------------------------
        # FILL ALL GROUPS TO ENHANCE PERFORMANCE
        # ------------------------------------------------
        $RabattGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonRG')
        while(-not $rs.EOF) {
            $RabattGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $WarenGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonWG')
        while(-not $rs.EOF) {
            $WarenGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $MengenEh = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT GR FROM KonMengenEh')
        while(-not $rs.EOF) {
            $MengenEh.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()

        $ErloesGr = New-Object -TypeName 'System.Collections.Generic.HashSet[string]'([StringComparer]::InvariantCultureIgnoreCase)
        $rs = $myConn.Execute('SELECT ErloesGR FROM KonErloesKonto')
        while(-not $rs.EOF) {
            $ErloesGr.Add($rs.Fields.Item(0).Value) | Out-Null
            $rs.MoveNext()
        }
        $rs.Close()



        if ($show) {
            try {
                $totalItems = $xml.EULANDA.ARTIKELLISTE.ARTIKEL.count
            } catch {
                $totalItems = 1
            }
            $currentItem = 0
            $item = [string]""
        }

        foreach($article in $xml.EULANDA.ARTIKELLISTE.ARTIKEL) {

            # ------------------------------------------------
            # IGNORE NODE WITHOUT UNIQUE KEY
            # ------------------------------------------------
            if ($article.PSObject.Properties.Name -contains "ARTNUMMER") {
                $articleNo = $article.ARTNUMMER
                $id = Get-ArticleId -articleNo $articleNo -conn $myConn
            } else {
                ARTICLENO_MISSING_IN_XML
                Write-Error ((Get-ResStr 'ARTICLENO_MISSING_IN_XML') -f  $myInvocation.Mycommand) -ErrorAction Continue
                Continue
            }

            if ($show) {
                $currentItem++
                $percentage = ($currentItem / $totalItems) * 100
                $item = $articleNo
                Write-Progress `
                    -Activity (Get-ResStr 'PROGBAR_XML_PROMPT') `
                    -Status ((Get-ResStr 'PROGBAR_XML_STATUS') -f $item, $currentItem, $totalItems) `
                    -PercentComplete $percentage
            }


            # ------------------------------------------------
            # CHECK IF IT IS ONLY AN PRICELIST UPDATE
            # ------------------------------------------------
            $articleChildNodes = $article.ChildNodes | Select-Object -ExpandProperty Name
            if ((@($articleChildNodes | Where-Object {$_ -notin $pricelistProperties})).Count -gt 0) {
                $onlyUpdateAllowed = $false
            } else {
                $onlyUpdateAllowed = $true
            }


            # ------------------------------------------------
            # NEW OR UPDATE
            # ------------------------------------------------
            if ($id) {
                # if we found an article we wont to update prices or an article
                $rs.Open("SELECT TOP 1 * FROM Artikel WHERE ID = $id", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
            } else  {
                if (! $onlyUpdateAllowed) {
                    $rs.Open("SELECT TOP 0 * FROM Artikel", $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
                    $rs.AddNew()
                    $rs.fields('ARTNUMMER').value = Convert-Accent -value $articleNo -strCase 'upper'
                } else {
                    # A price was found, but the article does not exist
                    # We do not want to insert an article with only prices
                    continue
                }
            }

            # ------------------------------------------------
            # PROCESS ANY XML NODE
            # ------------------------------------------------
            foreach ($node in $articleChildNodes) {
                if ((-not ($readOnlyFields -icontains $node)) -and (-not ($node -ieq 'ARTNUMMER'))) {
                    if (-not [string]::IsNullOrEmpty($article.$node)) {

                        # some special handlings
                        if ($node -ieq 'ARTMATCH') {
                            $rs.fields($node).value = Convert-Accent -value $article.$node -strCase 'upper'
                        } elseif ($node -ieq 'VK') {
                            $rs.fields('VK').value = $article.$node
                            # if not special BRUTTOFLG is found it is a price without VAT
                            if (-not ($article.PSObject.Properties.Name -contains 'BRUTTOFLG')) {
                                $rs.fields('BruttoFlg').value = 0
                            }
                        } elseif ($node -ieq 'VKNETTO') {
                            $rs.fields('VK').value = $article.$node
                            $rs.fields('BruttoFlg').value = 0
                        } elseif ($node -ieq 'VKBRUTTO') {
                            $rs.fields('VK').value = $article.$node
                            $rs.fields('BruttoFlg').value = 1
                        } elseif ($node -ieq 'VERPACKEH') {
                            if ($MengenEh.Contains($article.$node)) {
                                if ($article.$node -gt 1) {
                                    $rs.fields($node).value = $article.$node
                                } else {
                                    $rs.fields($node).value = 1
                                }
                            }
                        } elseif ($node -ieq 'MENGENEH') {
                            if ($MengenEh.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'WARENGR') {
                            if ($WarenGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'ERLOESGR') {
                            if ($ErloesGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        } elseif ($node -ieq 'RABATTGR') {
                            if ($RabattGr.Contains($article.$node)) {
                                $rs.fields($node).value = $article.$node
                            }
                        }
                        else {
                            $rs.fields($node).value = $article.$node
                        }
                    }
                }
            }

            # ------------------------------------------------
            # POST PROCESS e.g. COPPER SURCHARGE
            # ------------------------------------------------
            if ($cuSurcharge) {
                if ($rs.fields('USERN3').value -gt 0.001) {
                    $priceUnit = $rs.fields('PREISEH').value
                    if (! $priceUnit) {
                        $priceUnit = 1
                        $rs.fields('PREISEH').value = $priceUnit
                    }
                    # Copper surchagre must be multiplied, because it is a per unit price
                    if ($priceUnit -gt 1.001) {
                        $surcharge = [float]($rs.fields('PREISEH').value * $rs.fields('USERN3').value)
                    } else {
                        $surcharge = [float]$rs.fields('USERN3').value
                    }
                    $price = [float][math]::Round(($rs.fields('VK').value + $surcharge), 2)
                    $rs.fields('VK').value = [float]$price
                    $price = [float][math]::Round(($rs.fields('EKNetto').value + $surcharge), 2)
                    $rs.fields('EkNetto').value = [float]$price
                }
            }

            $rs.Update()
            $rs.Close()
        }
        $myConn.Close()

        if ($show) {
            Write-Progress -Activity (Get-ResStr 'PROGBAR_XML_PROMPT') -Completed
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Tets:  Import-ArticleFromXml -xml $xml -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -cuSurcharge
}
