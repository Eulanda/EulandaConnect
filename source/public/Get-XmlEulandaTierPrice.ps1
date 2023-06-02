Function Get-XmlEulandaTierPrice {
    param(
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [guid]$articleUid
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateCustomerGroups -customerGroups $_ })]
        [string]$customerGroups
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
        Test-ValidateSingle -validParams (Get-SingleArticleKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlTierPrice' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sqlTierPriceSimulation' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriter' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
            $articleId = Get-ArticleId  @paramsArticle  -conn $myConn

            # Get's the tier prices from regular tier price table
            [string]$sqlTierPrice = @"
            DECLARE @ArticleId INT = $articleId
            SELECT pl.Name, pl.Waehrung, pl.BruttoFlg, p.Staffel, p.MengeAb, p.Vk
            FROM PreisListe [pl]
            JOIN Preis [p] ON pl.Id = p.PreisListe
            JOIN Artikel art ON art.Id = p.ArtikelId
            WHERE art.Id = @ArticleId
            ORDER BY pl.Name, p.Staffel
"@

            # Simulates the tier price structure for an article
            # based on its rebate group and a list of customer groups
            [string]$sqlTierPriceSimulation = @"
            DECLARE @ArticleId INT = $articleId
            DECLARE @CustomerGroups VARCHAR(100) =  '$customerGroups'
            DECLARE @GroupList TABLE (GroupName VARCHAR(50))

            -- Split the @CustomerGroups into individual group names and into a table
            WHILE LEN(@CustomerGroups) > 0
            BEGIN
                DECLARE @CommaIndex INT
                SET @CommaIndex = CHARINDEX(',', @CustomerGroups)
                IF @CommaIndex = 0
                BEGIN
                    INSERT INTO @GroupList (GroupName) VALUES (LTRIM(RTRIM(@CustomerGroups)))
                    SET @CustomerGroups = ''
                END
                ELSE
                BEGIN
                    INSERT INTO @GroupList (GroupName) VALUES (LTRIM(RTRIM(LEFT(@CustomerGroups, @CommaIndex - 1))))
                    SET @CustomerGroups = SUBSTRING(@CustomerGroups, @CommaIndex + 1, LEN(@CustomerGroups) - @CommaIndex)
                END
            END

            DECLARE @Results TABLE (ArtNummer VARCHAR(50), Preis FLOAT, KG VARCHAR(50))
            DECLARE @Group VARCHAR(50)
            DECLARE groupCursor CURSOR FOR SELECT GroupName FROM @GroupList
            OPEN groupCursor
            FETCH NEXT FROM groupCursor INTO @Group

            WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO @Results (ArtNummer, Preis, KG)

                SELECT
                    art.ArtNummer,
                    art.VkNetto / 100.0 * (100.0 - rg.Rabatt),
                    @Group
                FROM
                    Artikel [art]
                    JOIN KonRgKG [rg] ON art.RabattGr = rg.Rg AND rg.KG = @Group
                WHERE
                    art.Id = @ArticleId

                FETCH NEXT FROM groupCursor INTO @Group
            END

            CLOSE groupCursor
            DEALLOCATE groupCursor

            SELECT KG [Name], 'EUR' [Waehrung], 0 [BruttoFlg], 1 [Staffel], 1.00 [MengeAb], Preis [Vk]
            FROM @Results
            ORDER BY ArtNummer, KG
"@

            if ($customerGroups) {
                [string]$sql = $sqlTierPriceSimulation
            } else {
                [string]$sql = $sqlTierPrice
            }

            $rs = $Null
            $rs = $myConn.Execute($sql)
            $rs = Get-AdoRs -recordset $rs
            if ($rs) {
                # Creating a MemoryStream object to store the XML text
                $memoryStream = New-Object System.IO.MemoryStream

                # Use xmlWriterSettings to change the default settings of the xmlWriter
                $xmlWriterSettings = New-Object System.Xml.XmlWriterSettings
                $xmlWriterSettings.Encoding = [System.Text.UTF8Encoding]::new()
                # Prevent the declaration at the beginning like: <?xml version="1.0" encoding="utf-8"?>
                $xmlWriterSettings.OmitXmlDeclaration = $true

                # Creating an XmlWriter object to write the XML structure
                $xmlWriter = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object
                $xmlWriter.WriteStartElement('PREISLISTE')
                while (! $rs.eof) {
                    $xmlWriter.WriteStartElement('PREIS')

                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        $xmlWriter.WriteElementString($nodeName,$nodeValue)
                    }

                    $xmlWriter.WriteEndElement()

                   $rs.movenext()
                }
                $xmlWriter.WriteEndElement()
                # Exiting the XmlWriter object
                $xmlWriter.Flush()
                $xmlWriter.Close()

                # Read memoryStream with streamreader
                $memoryStream.Position = 0
                $streamReader = New-Object System.IO.StreamReader($memoryStream)
                [string]$result = $streamReader.ReadToEnd()
            }
        }

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaTierPrice -articleNo '1100' -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
