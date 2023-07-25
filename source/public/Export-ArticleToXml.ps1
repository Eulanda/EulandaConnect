function Export-ArticleToXml {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNotEmpty -strParam $_ })]
        [string]$select = (Get-DefaultSelectArticle)
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$alias = 'articleNo'
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingArticleKeys) })]
        [string]$order = $alias
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
        [string]$breadcrumbPath = '\Shop'
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noEmptyPropertyTree
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

    # **************************************************************************
    # CREATE XML MESSAGE: ARTICLE
    # **************************************************************************

    Begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingArticleKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingArticleKeys)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlArticle' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlPropertyTree' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsArticle' -Scope 'Private' -Value (@{})
        New-Variable -Name 'Result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsArticle = Get-UsedParameters -validParams (Get-SetArticleWithGroupsFilter) -boundParams $PSBoundParameters

        # **************************************************************************
        # Create a raw version for each database section
        # **************************************************************************

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for PropertyTree
        if ($breadcrumbPath) {
            [xml]$xmlPropertyTree = Get-XmlEulandaProperty -breadcrumbPath $breadcrumbPath -tablename 'Article' -conn $myConn
        } else {
            [xml]$xmlPropertyTree = '<MERKMALBAUM><ARTIKEL /></MERKMALBAUM>'
        }
        if ($noEmptyPropertyTree -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes.Count -eq 1 -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes[0].IsEmpty) {
                [xml]$xmlPropertyTree = $null
        }

        # XML RAW for all articles including nodes like SHOP, LAGER, PREISLISTE, MERKMALLISTE
        [xml]$xmlArticle = Get-XmlEulandaArticle @paramsArticle -conn $myConn


        # **************************************************************************
        # Assemble the individual XML nodes into an XML message.
        # **************************************************************************

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlPropertyTree) {
            $newNode = $xmlPropertyTree.SelectSingleNode("//MERKMALBAUM")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($xmlArticle) {
            if ($xmlArticle.OuterXml) {
                $newNode = $xmlArticle.SelectSingleNode("//ARTIKELLISTE")
                $node = $xml.ImportNode($newNode, $true)
                $xml.DocumentElement.AppendChild($node) | Out-Null
            }
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-ArticleToXml -filter "ArtNummer>='1000' and ArtNummer<='1100'" -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl' -path "$(Get-DesktopDir)\ARTICLE.xml"
    # Test:  Export-ArticleToXml -filter "ArtNummer>='1000' and ArtNummer<='1100'" -customerGroups 'HA,HB,HC' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
