function Get-XmlEulandaAddress {
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateSelect -strParam $_ })]
        [string]$select= '*'
        ,
        [parameter(Mandatory = $false)]
        [string[]]$filter
        ,
        [parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateMapping -strValue $_ -mapping (Get-MappingAddressKeys) })]
        [string]$alias = 'addressMatch'
        ,
        [parameter(Mandatory = $false)]
        [string]$order = $alias
        ,
        [parameter(Mandatory = $false)]
        [switch]$reorder
        ,
        [parameter(Mandatory = $false)]
        [switch]$revers
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
        $alias = Test-ValidateMapping -strValue $alias -mapping (Get-MappingAddressKeys)
        $order = Test-ValidateMapping -strValue $order -mapping (Get-MappingAddressKeys)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'nodeValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'ParamsAddress' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string[]]@())
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        $ParamsAddress = Get-UsedParameters -validParams (Get-SetAddressFilter) -boundParams $PSBoundParameters
        [string[]]$sql= Get-AddressSql @ParamsAddress
        $rs = $Null
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
            $writer.WriteStartElement('ADRESSELISTE')
            while (! $rs.eof) {
                $writer.WriteStartElement('ADRESSE')
                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                    [string]$nodeValue = [string]$rs.fields[$i].value
                    $writer.WriteElementString($nodeName,$nodeValue)
                }
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
    # Test:  Get-XmlEulandaAddress -filter "Match='EULANDA'" -select 'Match,Name1,Name2,Name3,Strasse,Plz,Ort' -alias 'addressMatch' -udl 'C:\temp\Eulanda_1 Eulanda.udl'
}
