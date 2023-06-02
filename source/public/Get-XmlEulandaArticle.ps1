function Get-XmlEulandaArticle {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select= (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [string]$order= $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateCustomerGroups -CustomerGroups $_ })]
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

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'articleNo' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlString' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$result = ""
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SetArticleFilter) -boundParams $PSBoundParameters

        [string[]]$sql= Get-ArticleSql @paramsArticle
        $rs = $myConn.Execute($sql[0])
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
            $writer.WriteStartElement('ARTIKELLISTE')

            while (! $rs.eof) {
                # ADD NODE ARTIKEL (one article including other sub nodes like shop)
                $writer.WriteStartElement('ARTIKEL')

                    # ADD NODE FIELDS ARTIKEL (article fields)
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                        [string]$nodeValue = [string]$rs.fields[$i].value
                        $writer.WriteElementString($nodeName,$nodeValue)
                    }

                    # GET ARTICLENO for inserting all other nodes
                    $articleNo = $rs.fields['ARTNUMMER'].value

                    # ADD NODE SHOP (online shop items)
                    if (Test-ShopExtension -conn $myConn) {
                        $xmlString = Get-XmlEulandaShop -articleNo $articleNo -conn $myConn
                        $writer.WriteRaw($xmlString)
                    }

                    # ADD NODE LAGER (stock)
                    $xmlString= Get-XmlEulandaStock -articleNo $articleNo -conn $myConn
                    $writer.WriteRaw($xmlString)

                    # ADD NODE PREISLISTE (price list)
                    $xmlString= Get-XmlEulandaTierPrice -articleNo $articleNo -customerGroups $customerGroups -conn $myConn
                    $writer.WriteRaw($xmlString)

                    # ADD NODE MERKMALLISTE (list of breadcrumb)
                    $xmlString= Get-XmlEulandaBreadcrumb -articleNo $articleNo -tablename 'Article' -breadcrumbpath '\shop' -conn $myConn
                    $writer.WriteRaw($xmlString)

                $writer.WriteEndElement()
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

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaArticle -filter "ArtNummer='1100'"  -customerGroups 'HA,HB,HC' -alias 'Barcode' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
    # Test:  Get-XmlEulandaArticle -filter "ArtNummer='130100'" -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}
