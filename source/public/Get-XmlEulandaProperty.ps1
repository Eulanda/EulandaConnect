function Get-XmlEulandaProperty {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$breadcrumbPath = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'breadcrumbPath', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingTablename) })]
        [string]$tablename = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'tablename', $myInvocation.Mycommand))
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
        $tablename = Test-ValidateMapping -strValue $tablename -mapping (Get-MappingTablename)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'child' -Scope 'Private' -Value ($null)
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Object[]]@())
        New-Variable -Name 'idMap' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'parent' -Scope 'Private' -Value ($null)
        New-Variable -Name 'parentId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'properties' -Scope 'Private' -Value ($null)
        New-Variable -Name 'property' -Scope 'Private' -Value ($null)
        New-Variable -Name 'root' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rootId' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'subNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlFlat' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlHierarchy' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            [string[]]$sql= Get-PropertySql -breadcrumbPath $breadcrumbPath -tablename $tablename
            [System.Object]$data = Get-DataFromSql -sql $sql -conn $myConn
            if ($data) {
                [xml]$xmlFlat = Convert-DataToXml -data $data -root 'EULANDA' -arrRoot 'MERKMALLISTE' -arrSubRoot 'MERKMAL'
            } else {
                [xml]$xmlFlat = '<MERKMALBAUM><ARTIKEL /></MERKMALBAUM>'
            }

            # Create a hash map with all ID values
            # MERKMAL (engl. =Property)
            $idMap = @{}
            foreach ($property in $xmlFlat.SelectNodes("//MERKMAL")) {
                $idMap[$property.Id] = $true
            }

            # Traversing all ParentId values and searching for the rootId
            # MERKMAL (engl. =Property)
            $rootId = $null
            foreach ($property in $xmlFlat.SelectNodes("//MERKMAL")) {
                $parentId = $property.ParentId
                if ($parentId -ne "" -and !$idMap.ContainsKey($parentId)) {
                    $rootId = $parentId
                    break
                }
            }

            # Create a new XML document for the hierarchy
            $xmlHierarchy = New-Object System.Xml.XmlDocument
            $root = $xmlHierarchy.CreateElement("MERKMALBAUM")
            $xmlHierarchy.AppendChild($root) | Out-Null

            # Converting the list of flat properties into a hierarchy
            $properties = $xmlFlat.SelectNodes("//MERKMAL")
            foreach ($property in $properties) {
                $parentId = $property.ParentId
                if ($parentId -eq $rootId) {
                    $root.AppendChild($xmlHierarchy.ImportNode($property, $true)) | Out-Null
                } else {
                    $parent = $xmlHierarchy.SelectSingleNode("//MERKMAL[ID=$parentId]")
                    $parent.AppendChild($xmlHierarchy.ImportNode($property, $true)) | Out-Null
                }
            }

            # Move all the child elements of 'MERKMALBAUM' to 'MERKMALBAUM\ARTIKEL' or what ever
            # MERKMALBAUM (eng. =PropertyTree), ARTIKEL (eng. = Article)
            $subNode = $xmlHierarchy.CreateElement($tablename.ToUpper())
            foreach ($child in $xmlHierarchy.SelectNodes("//MERKMALBAUM/*")) {
                $subNode.AppendChild($child.CloneNode($true)) | Out-Null
            }
            # Remove the original child nodes of the root
            $xmlHierarchy.DocumentElement.RemoveAll()
            # Add the subnode like ARTIKEL as the new child of the root
            $xmlHierarchy.DocumentElement.AppendChild($subNode) | Out-Null

            $result = $xmlHierarchy.OuterXml
        }

        catch {
            Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
        }
    }

    End {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaProperty -breadcrumbPath '\Produkte' -tablename 'Adresse' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}

