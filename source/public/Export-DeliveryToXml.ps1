function Export-DeliveryToXml {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$deliveryId
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateNo -no $_ })]
        [int]$deliveryNo
        ,
        [Parameter(Mandatory = $false)]
        [switch]$includeEmpty
        ,
        [Parameter(Mandatory = $false)]
        [string[]]$sql = $(
            if ($deliveryId) {
                Get-DeliverySql -deliveryId $deliveryId
            } else {
                Get-DeliverySql -deliveryNo $deliveryNo
            }
        )
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

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleDeliveryKeys) @PSBoundParameters
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'newNode' -Scope 'Private' -Value ($null)
        New-Variable -Name 'node' -Scope 'Private' -Value ($null)
        New-Variable -Name 'paramsDelivery' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlDelivery' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlMetadata' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $paramsDelivery = Get-UsedParameters -validParams (Get-SingleDeliveryKeys) -boundParams $PSBoundParameters

        # **************************************************************************
        # Create a raw version for each database section
        # **************************************************************************

        # XML RAW for Root
        [xml]$xml = Get-XmlEulandaRoot

        # XML RAW for Metadata
        [xml]$xmlMetadata = Get-XmlEulandaMetadata

        # XML RAW for Delivery
        [xml]$xmlDelivery = Get-XmlEulandaDelivery @paramsDelivery -sql $sql -includeEmpty:$includeEmpty -conn $myConn


        # **************************************************************************
        # Assemble the individual XML nodes into an XML message.
        # **************************************************************************

        $newNode = $xmlMetadata.SelectSingleNode("//METADATA")
        $node = $xml.ImportNode($newNode, $true)
        $xml.DocumentElement.AppendChild($node) | Out-Null

        if ($xmlDelivery) {
            $newNode = $xmlDelivery.SelectSingleNode("//LIEFERSCHEINLISTE")
            $node = $xml.ImportNode($newNode, $true)
            $xml.DocumentElement.AppendChild($node) | Out-Null
        }

        if ($path) {
            Format-Xml -xmlString $xml.OuterXml -pathOut $path
        } else {
            [string]$result= (Format-Xml -xmlString $xml.OuterXml)
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Export-DeliveryToXml -deliveryNo 430952 -includeEmpty -udl 'C:\temp\Eulanda_1 JohnDoe.udl' -debug
}