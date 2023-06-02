function Test-XmlSchema {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$xmlFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'xmlFile', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [string]$schemaFile = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'schemaFile', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'schema' -Scope 'Private' -Value ($null)
        New-Variable -Name 'schemaReader' -Scope 'Private' -Value ($null)
        New-Variable -Name 'validationEventHandler' -Scope 'Private' -Value ($null)
        New-Variable -Name 'xml' -Scope 'Private' -Value ($null)
        New-Variable -Name 'result' -Scope 'Private' -Value ([boolean]$false)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [string[]]$Script:xmlValidationErrorLog = @()
        [scriptblock] $validationEventHandler = {
            $Script:xmlValidationErrorLog += "$($args[1].Exception.Message)`r`n"
        }

        $xml = New-Object System.Xml.XmlDocument
        $schemaReader = New-Object System.Xml.XmlTextReader $schemaFile
        $schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $validationEventHandler)
        $xml.Schemas.Add($schema) | Out-Null
        $xml.Load($XmlFile)
        $xml.Validate($validationEventHandler)

        if ($Script:xmlValidationErrorLog) {
            # $result = $false
            Write-Warning ((Get-ResStr 'TOTAL_ERRORS_FOUND') -f $Script:xmlValidationErrorLog.Count)
            Throw "$Script:xmlValidationErrorLog"
        }
        else {
            # $result = $true
            Write-Verbose ((Get-ResStr 'XML_SCHEMA_VALIDATED') -f (Get-Filename -path $xmlFile), (Get-Filename -path $schemaFile))
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return
    }
    # Test: Test-XmlSchema -xmlFile 'c:\temp\article.xml' -schemaFile  'c:\temp\article.xsd'
}
