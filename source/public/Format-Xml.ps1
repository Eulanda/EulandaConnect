function Format-Xml {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$xmlString
        ,
        [Parameter(Mandatory = $false)]
        [string]$pathIn
        ,
        [Parameter(Mandatory = $false)]
        [string]$pathOut
        ,
        [Parameter(Mandatory = $false)]
        [switch]$removeDecoration
        ,
        [Parameter(Mandatory = $false)]
        [switch]$setDecoration
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'data' -Scope 'Private' -Value ([System.Collections.ArrayList]@())
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'strWriter' -Scope 'Private' -Value ([System.IO.StringWriter]::new())
        New-Variable -Name 'writer' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference

        # Parameter validation in PowerShell doesn't support function-generated error messages

        # Rule 1: If XmlString is provided, PathIn cannot be provided and vice versa. But one of them must be provided
        if (![string]::IsNullOrEmpty($xmlString) -and ![string]::IsNullOrEmpty($pathIn)) {
            throw (Get-ResStr 'SPECIFY_XMLSTRING_OR_XMLFILE')
        } elseif ([string]::IsNullOrEmpty($xmlString) -and [string]::IsNullOrEmpty($pathIn)) {
            throw (Get-ResStr 'SPECIFY_XMLSTRING_OR_XMLFILE')
        }

        # Rule 2: PathIn must exist, if used
        if (![string]::IsNullOrEmpty($pathIn) -and !(Test-Path $pathIn)) {
            throw ((Get-ResStr 'PATHIN_DOES_NOT_EXIST') -f $pathIn)
        }

        # Rule 3: PathOut must exist, if used
        if (![string]::IsNullOrEmpty($pathOut) -and !(Test-Path (Split-Path $pathOut -Parent))) {
            throw ((Get-ResStr 'PATHOUT_DOES_NOT_EXIST') -f $pathOut)
        }
    }

    process {
        if ($pathIN) {
            $xmlString = Get-Content -Path $pathIn
        }

        [System.Collections.ArrayList]$data = New-Object System.Collections.ArrayList
        $data.Add($xmlString -join "`n") | Out-Null
        [System.Xml.XmlDataDocument]$xml= New-Object System.Xml.XmlDataDocument
        $xml.LoadXml($data -join "`n")

        if ($removeDecoration) {
            # Check if XML declaration is present and remove it
            if ($xml.FirstChild -is [System.Xml.XmlDeclaration]) {
                $xml.RemoveChild($xml.FirstChild) | Out-Null
            }
        }

        if ($setDecoration) {
            if (! ($xml.FirstChild -is [System.Xml.XmlDeclaration])) {
                $xmlString = $xml.OuterXml
                $i = $xmlString.IndexOf("<?")
                if ($i -lt 0) {
                    $xmlString = ('<?xml version="1.0" encoding="UTF-8"?>' + $xmlString)
                }

                [System.Collections.ArrayList]$data = New-Object System.Collections.ArrayList
                $data.Add($xmlString -join "`n") | Out-Null
                [System.Xml.XmlDataDocument]$xml= New-Object System.Xml.XmlDataDocument
                $xml.LoadXml($data -join "`n")
            }
        }

        [System.IO.StringWriter]$strWriter= New-Object System.Io.Stringwriter
        [System.Xml.XmlTextWriter]$writer= New-Object System.Xml.XmlTextWriter($strWriter)
        $writer.Formatting = [System.Xml.Formatting]::Indented
        $writer.Indentation = 4
        $writer.IndentChar = " "
        $xml.WriteContentTo($writer)
        if ($pathOut) {
            $strWriter.ToString() | Out-File -FilePath $pathOut -Encoding UTF8
        } else {
            $result = $strWriter.ToString()
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test: Format-Xml -xmlString '<Root><Item /></Root>'
}
