function Export-PropertyToXml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noEmptyPropertyTree
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathXML -path $_  })]
        [string]$path
        ,
        [Parameter(Mandatory = $false)]
        [AllowNull()]
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
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlPropertyTree' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ('')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for PropertyTree
        if ($breadcrumbPath) {
            [xml]$xmlPropertyTree = Get-XmlEulandaProperty -breadcrumbPath $breadcrumbPath -tablename $tablename -conn $myConn
        } else {
            [xml]$xmlPropertyTree = '<MERKMALBAUM><ARTIKEL /></MERKMALBAUM>'
        }

        if ($noEmptyPropertyTree -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes.Count -eq 1 -and
            $xmlPropertyTree.Merkmalbaum.ChildNodes[0].IsEmpty) {
                [xml]$xmlPropertyTree = $null
        }

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlPropertyTree) {
            $newNode = $xmlPropertyTree.SelectSingleNode("//MERKMALBAUM")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result = (Format-Xml -xmlString $xml.OuterXml)
        }

    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-PropertyToXml -breadcrumbPath '\Shop' -tablename 'Article' -udl 'C:\temp\Eulanda_1 Eulanda.udl' -path "$(Get-DesktopDir)\PROPERTYTREE.xml"
    # Test:  Export-PropertyToXml -breadcrumbPath '\Produkte' -tablename 'Address' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
