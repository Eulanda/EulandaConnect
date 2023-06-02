function Write-XmlMetadata {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $writer = $(Throw (Get-ResStr 'PARAM_OBJECT_WRITER_MISSED'))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'upper'
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'nodeName' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string]$nodeName = (Convert-StringCase -value ('Metadata') -strCase $strCase)
        $writer.WriteStartElement($nodeName)
            [string]$nodeName = (Convert-StringCase -value ('Version') -strCase $strCase)
            $writer.WriteElementString($nodeName,$ecModuleVersion.toString())

            [string]$nodeName = (Convert-StringCase -value ('Generator') -strCase $strCase)
            $writer.WriteElementString($nodeName,'EulandaConnect')

            [string]$nodeName = (Convert-StringCase -value ('Dateformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'ISO8601')

            [string]$nodeName = (Convert-StringCase -value ('Floatformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'US')

            [string]$nodeName = (Convert-StringCase -value ('Countryformat') -strCase $strCase)
            $writer.WriteElementString($nodeName,'ISO2')

            [string]$nodeName = (Convert-StringCase -value ('Fieldnames') -strCase $strCase)
            $writer.WriteElementString($nodeName,'NATIVE')

            [string]$nodeName = (Convert-StringCase -value ('Date') -strCase $strCase)
            $writer.WriteElementString($nodeName,(Convert-DateToIso -value $(Get-Date) -noTimeZone ))

            [string]$nodeName = (Convert-StringCase -value ('PCName') -strCase $strCase)
            $writer.WriteElementString($nodeName, "$env:COMPUTERNAME".ToUpper())

            [string]$nodeName = (Convert-StringCase -value ('UserName') -strCase $strCase)
            $writer.WriteElementString($nodeName, "$env:USERNAME".ToUpper())

        $writer.WriteEndElement()
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $writer
    }
    # Test: $stream = New-Object System.IO.MemoryStream;$settings = New-Object System.Xml.XmlWriterSettings;$writer = [System.XML.XmlWriter]::Create($stream, $settings);Write-XmlMetadata -writer $writer
}
