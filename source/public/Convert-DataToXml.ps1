function Convert-DataToXml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        $data = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'data', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [switch]$metadata
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateStringCase $_ })]
        [string]$strCase = 'none'
        ,
        [Parameter(Mandatory = $false)]
        [string]$root = 'Root'
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrRoot = 'Records'
        ,
        [Parameter(Mandatory = $false)]
        [string]$arrSubRoot = 'Record'
    )

    function Convert-DataToXmlInner {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory = $false)]
            $data = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'data', $myInvocation.Mycommand))
            ,
            [Parameter(Mandatory = $false)]
            [switch]$metadata
            ,
            [Parameter(Mandatory = $false)]
            [ValidateScript({ Test-ValidateStringCase $_ })]
            [string]$strCase = 'none'
            ,
            [Parameter(Mandatory = $false)]
            [string]$root = 'Root'
            ,
            [Parameter(Mandatory = $false)]
            [string]$arrRoot = 'Records'
            ,
            [Parameter(Mandatory = $false)]
            [string]$arrSubRoot = 'Record'
            ,
            [Parameter(Mandatory = $false)]
            $writer
            ,
            [Parameter(Mandatory = $false)]
            [int]$level
        )

        begin {
            Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
            New-Variable -Name 'encoding' -Scope 'Private' -Value ([System.Text.Encoding]::UTF8)
            New-Variable -Name 'i' -Scope 'Private' -Value (0)
            New-Variable -Name 'key' -Scope 'Private' -Value ('')
            New-Variable -Name 'nodeName' -Scope 'Private' -Value ('')
            New-Variable -Name 'on' -Scope 'Private' -Value ($false)
            New-Variable -Name 'reader' -Scope 'Private' -Value ($null)
            New-Variable -Name 'settings' -Scope 'Private' -Value ($null)
            New-Variable -Name 'spaces' -Scope 'Private' -Value ('')
            New-Variable -Name 'stream' -Scope 'Private' -Value ($null)
            New-Variable -Name 'strValue' -Scope 'Private' -Value ('')
            New-Variable -Name 'value' -Scope 'Private' -Value ($null)
            New-Variable -Name 'xmlString' -Scope 'Private' -Value ('')
            New-Variable -Name 'result' -Scope 'Private' -Value ($null)
            $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
        }

        process {
            if ($DebugPreference -eq "Continue") {
                $on = $true
            } else {
                $on = $false
            }

            $root = Convert-StringCase -value $root -strCase $strCase

            if ($level -eq 0) {
                if ($on) { Write-Host "BEGIN: $root  (:$level)" -ForegroundColor Cyan }
                # On level=0 it is a good way to initialize the xmlWriter
                $encoding = [System.Text.Encoding]::UTF8
                $settings = New-Object System.Xml.XmlWriterSettings
                $settings.Indent = $true
                $settings.IndentChars = "  "
                $settings.Encoding = $encoding
                $stream = New-Object System.IO.MemoryStream
                $writer = [System.XML.XmlWriter]::Create($stream, $settings)

                # Start with the root node
                $writer.WriteStartDocument()
                $writer.WriteStartElement($root)
                if ($metadata) {
                    $writer = Write-XmlMetadata -writer $writer -strCase $strCase
                }
            }

            if  (($data -is [System.Collections.ArrayList]) -or ($data -is [System.Object[]])) {
                $nodeName = (Convert-StringCase -value ($arrRoot) -strCase $strCase)
                $writer.WriteStartElement($nodeName)
                if ($on) { Write-Host "ROOT.Array(max$($data.count)): $nodeName (:$level)" -ForegroundColor Red }
                for ($i=0; $i -lt $data.count; $i++) {
                    $nodeName = (Convert-StringCase -value $arrSubRoot -strCase $strCase)
                    $writer.WriteStartElement($nodeName)
                    if ($on) { Write-Host "ROOT.Array($i): $nodeName (:$level)" -ForegroundColor Red }
                    # $nodeName = (Convert-StringCase -value ($root+$plural) -strCase $strCase)
                    if ($data[$i] -is [System.Collections.Specialized.OrderedDictionary]) {
                        if ($on) { Write-Host "hash(max$($data[$i].count)): $nodeName (:$level+1)" -ForegroundColor blue }
                    }
                    Convert-DataToXmlInner -data $data[$i] -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                    $writer.WriteEndElement()
                }
                $writer.WriteEndElement()
            } else {
                foreach ($key in $data.Keys) {
                    $value = $data[$key]
                    if (($value -is [System.Collections.ArrayList]) -or ($value -is [System.Object[]])) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        if ($on) { Write-Host "array(max$($value.count)): $nodeName (:$level)" -ForegroundColor Red }
                        for ($i=0; $i -lt $value.count; $i++) {
                            $nodeName = (Convert-StringCase -value $arrSubRoot -strCase $strCase)
                            $writer.WriteStartElement($nodeName)
                            if ($on) { Write-Host "array($i): $nodeName (:$level)" -ForegroundColor Red }
                            # $nodeName = (Convert-StringCase -value ($key+$plural) -strCase $strCase)
                            if ($value[$i] -is [System.Collections.Specialized.OrderedDictionary]) {
                                if ($on) { Write-Host "hash(max$($value[$i].count)): $nodeName (:$level+1)" -ForegroundColor blue }
                            }
                            Convert-DataToXmlInner -data $value[$i] -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                            $writer.WriteEndElement()
                        }
                        $writer.WriteEndElement()
                    } elseif ($value -is [System.Collections.Hashtable]) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        if ($on) { Write-Host "hash(max$($value.count)): $nodeName (:$level)" -ForegroundColor blue }
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        Convert-DataToXmlInner -data $value -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                        $writer.WriteEndElement()
                    } elseif ($value -is [System.Collections.Specialized.OrderedDictionary]) {
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteStartElement($nodeName)
                        Convert-DataToXmlInner -data $value -root $nodeName -level ($level+1) -writer $writer -strCase $strCase -arrRoot $arrRoot -arrSubRoot $arrSubRoot
                        $writer.WriteEndElement()
                    } else { # hash values comes here like: System.Collections.Specialized.OrderedDictionary
                        # Here we have the xml node data
                        if ($null -eq $value) {
                            $strValue= ''
                        } else {
                            if ($value.GetType().Name -eq 'DateTime') {
                                $strValue = Convert-DateToIso -value $value -noTimeZone
                            } else {
                                $strValue = [string]$value
                            }
                        }
                        $nodeName = (Convert-StringCase -value ($key) -strCase $strCase)
                        $writer.WriteElementString($nodeName,$strValue)
                        $spaces = Get-Spaces -count ($level * 4)
                        if ($on) { Write-Host "$($spaces)$($nodeName) = '$strValue' (:$level)" -ForegroundColor Green }
                    }
                }
            }

            # If the level is '0' when the function results exits,
            # all recursions are done and the XmlWriter can be closed.
            if ($level -eq 0) {
                if ($on) { Write-Host "END: $root  (:$level)" -ForegroundColor Cyan }
                $writer.WriteEndElement()
                $writer.WriteEndDocument()
                $writer.Flush()
                $writer.Close()

                # Transfer the content of the memory stream to
                # a string and then to a standard XML object
                $stream.Position = 0
                $reader = New-Object System.IO.StreamReader($stream)
                $xmlString = $reader.ReadToEnd()
                [xml]$result = $xmlString
            }
        }

        end {
            Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
            if ($level -eq 0) { Return $result }
        }

    }

    $result = Convert-DataToXmlInner -data $data -metadata:$metadata -strCase $strCase -root $root  -arrRoot $arrRoot -arrSubRoot $arrSubRoot -Debug:$DebugPreference
    Return $result
    # Test:  (Convert-DataToXml -data @([ordered]@{'Field1'='Value1';'Field2'='Value2'}, [ordered]@{'Field3'='Value3';'Field4'='Value4'})).OuterXml
}

