function Get-XmlEulandaMetadata {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [switch]$noUsername
        ,
        [Parameter(Mandatory = $false)]
        [switch]$noPcName
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'memoryStream' -Scope 'Private' -Value ($null)
        New-Variable -Name 'streamReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xmlWriterSettings' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
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
        $writer.WriteStartElement('METADATA')
            $writer.WriteElementString('VERSION',$global:ecModuleVersion.ToString())
            $writer.WriteElementString('GENERATOR',$global:ecModuleName)
            $writer.WriteElementString('DATEFORMAT','ISO8601')
            $writer.WriteElementString('FLOATFORMAT','US')
            $writer.WriteElementString('COUNTRYFORMAT','ISO2')
            $writer.WriteElementString('FIELDNAMES','NATIVE')
            $writer.WriteElementString('DATE',(Convert-DateToIso -value $(Get-Date) -noTimeZone ))
            if (! $noPcName) {
                $writer.WriteElementString('PCNAME', "$env:COMPUTERNAME".ToUpper())
            }
            if (! $noUserName) {
                $writer.WriteElementString('USERNAME', "$env:USERNAME".ToUpper())
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

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-XmlEulandaMetadata
}
