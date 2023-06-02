function Get-HtmlMetaData {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$description
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([System.Collections.Hashtable]@{})
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        [hashtable]$result = @{
            author="EULANDA Software GmbH - ERP-Systems - Germany"
            generator="Powershell $($PsVersiontable.GitCommitId) by function ConvertTo-Html"
            keywords="eulanda, erp, powershell, convertto-html, html"
            viewport="width=device-width, initial-scale=1.0"
        }
        if ($description) {
            $result.Add('description', $description) | Out-Null
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlMetaData -description 'My meta description'
}
