function Get-XmlEulandaStock {
    [CmdletBinding()]
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
        New-Variable -Name 'rawSql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    Process {
        $paramsArticle = Get-UsedParameters -validParams (Get-SingleArticleKeys) -boundParams $PSBoundParameters

        try {
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            [int]$articleId = Get-ArticleId @paramsArticle -conn $myConn
            [string]$rawSql = (Get-StockSql -legacy -alias 'articleId')[1]
            [string]$sql= ($rawSql -f $articleId )
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

                $writer.WriteStartElement('LAGER')

                for ($i=0; $i -lt $rs.fields.count; $i++) {
                    [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                    [string]$nodeValue = [string]$rs.fields[$i].value
                    $writer.WriteElementString($nodeName,$nodeValue)
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
    # Test:  Get-XmlEulandaStock -articleNo '130100' -udl 'C:\temp\Eulanda_1 Truccamo.udl'
}
