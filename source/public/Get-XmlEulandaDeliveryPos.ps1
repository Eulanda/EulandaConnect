function Get-XmlEulandaDeliveryPos {
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
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlValue' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        try {
            [string]$result = ""
            $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr

            $rs = $Null
            $rs = $myConn.Execute("$($sql[1]) ORDER BY 1" )
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

                $writer.WriteStartElement('LIEFERSCHEINPOSLISTE')
                while (! $rs.eof) {
                    $writer.WriteStartElement('LIEFERSCHEINPOS')
                    for ($i=0; $i -lt $rs.fields.count; $i++) {
                        if (($includeEmpty) -or (![string]::IsNullOrEmpty($rs.fields[$i].Value))) {
                            [string]$nodeName = $rs.fields[$i].Name.ToUpper()
                            [string]$xmlValue = ConvertTo-XmlString -adoField $rs.fields[$i] -includeEmpty:$includeEmpty
                            if (($includeEmpty) -or ($xmlValue)) {
                                $writer.WriteElementString($nodeName, $xmlValue)
                            }
                        }
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

        catch {
            if ($Error.Count -gt 0) {
                $line = $myInvocation.ScriptLineNumber - 1
                Throw ((Get-ResStr 'EXCEPTION_GENERAL_EXT') -f $_, $($myInvocation.Mycommand), $($line), $($Error[0].Exception.Message) )
            } else {
                Throw ((Get-ResStr 'EXCEPTION_GENERAL') -f $_, $($myInvocation.Mycommand))
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:   Get-XmlEulandaDeliveryPos -DeliveryNo 430952 -Udl 'C:\Temp\Eulanda_1 JohnDoe.udl'
}
