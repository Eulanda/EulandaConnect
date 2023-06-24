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

        $readOnlyFields = Get-ReadOnlyFields -conn $myConn -tablename 'Artikel'
        # We are making special handlings with these price fields
        $readOnlyFields = $readOnlyFields | Where-Object { $_ -ne "VKNETTO" -and $_ -ne "VKBRUTTO" }

        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        $pricelistProperties = @("ARTNUMMER", "EKNETTO", "VKNETTO", "VKBRUTTO", "BRUTTOFLG", "VK", "EK2NETTO")

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



        foreach($article in $xml.EULANDA.ARTIKELLISTE.ARTIKEL) {

            # ------------------------------------------------
            # IGNORE NODE WITHOUT UNIQUE KEY
            # ------------------------------------------------
            if ($article.PSObject.Properties.Name -contains "ARTNUMMER") {
                $articleNo = $article.ARTNUMMER
                $id = Get-ArticleId -articleNo $articleNo -conn $myConn
            } else {
                Write-Error "ArticleNo not present in xml!" -ErrorAction Continue
                Continue
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
                }
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
