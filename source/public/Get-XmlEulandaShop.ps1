function Get-XmlEulandaShop {
    param (
        [Parameter(Mandatory = $false)]
        [string]$barcode
        ,
        [Parameter(Mandatory = $false)]
        [string]$articleNo
        ,
        [Parameter(Mandatory = $false)]
        [Alias('id')]
        [int]$articleId
        ,
        [Parameter(Mandatory = $false)]
        [Alias('uid')]
        [guid]$articleUid
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
        New-Variable -Name 'idx' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'upselling' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            [string]$result = ''

            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            if (! (Test-ShopExtension -conn $myConn)) {
                Throw ((Get-ResStr 'FUNCTION_NEEDS_SHOP_EXTENSIONS') -f $($myInvocation.Mycommand))
            }

            [int]$articleId = Get-ArticleId @paramsArticle -conn $myConn
            [string]$sql = @"
            DECLARE @ShopFields NVARCHAR(MAX);
            SET @ShopFields = STUFF(
                    (
                        SELECT ', Arts.' + COLUMN_NAME
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_NAME = 'esolArtikelShop'
                        AND COLUMN_NAME NOT IN ('ID', 'VariantText1', 'VariantText2', 'VariantText3', 'VariantText4', 'VariantText5')
                        FOR XML PATH('')
                    ), 1, 2, ''
            );

            DECLARE @MasterFields NVARCHAR(MAX);
            SET @MasterFields = 'Master.VariantText1, Master.VariantText2, Master.VariantText3, Master.VariantText4, Master.VariantText5';

            DECLARE @AddressFields NVARCHAR(MAX);
            SET  @AddressFields = 'adr.Match [MANUFACTURER]';

            DECLARE @sql NVARCHAR(MAX);
            SET @sql = N'
            SELECT ' + @ShopFields + ', ' + @MasterFields + ', ' + @AddressFields + '
            FROM esolArtikelShop [arts]
            LEFT JOIN Artikel art ON art.ID = arts.ID
            LEFT JOIN Adresse adr ON adr.ID = art.HerstellerID
            LEFT JOIN esolArtikelShop Master ON Master.ID = (SELECT ID FROM Artikel WHERE ArtNummer = arts.MasterArticle)
            WHERE art.Id = $articleId';

            EXEC sp_executesql @sql;
"@

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
                $writer = [System.Xml.XmlWriter]::Create($memoryStream, $xmlWriterSettings)
                # Writing the XML structure with the XmlWriter object

                $upselling= Get-UpsellingFromVariants @paramsArticle -conn $myConn

                $writer.WriteStartElement('SHOP')
                while (! $rs.eof) {
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        # An automatic upselling is set up when dealing with variants that consist of more
                        # than one unit. If no upselling has been specified, it is formed from these variants.
                        if (($upselling) -and ($upselling.count -gt 0)) {
                            if ($nodeName -match "^Up[1-8]$") {
                                if (! $nodeValue) {
                                    [int]$idx = [int]$nodeName.Substring(2)
                                    if ($upselling.count -ge $idx) {
                                        $nodeValue = $upselling[$idx-1]
                                    };
                                }
                            }
                        }

                        $writer.WriteElementString($nodeName,$nodeValue)
                    }
                    $rs.MoveNext()
                }
                $writer.WriteEndElement()
                # Exiting the XmlWriter object
                $writer.Flush()
                $writer.Close()

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
    # Test:  Get-XmlEulandaShop -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}