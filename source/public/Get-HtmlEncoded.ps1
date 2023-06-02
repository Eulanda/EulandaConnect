function Get-HtmlEncoded {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$taggedString
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $result = $taggedString
        $result = $result.replace('\r', '')
        $result = $result.replace('\n', '{br/}')

        # Replace <br> and <strong> tags with placeholders
        $result = $result -replace "`r", ''
        $result = $result -replace "`n", '{br/}'
        $result = $result -replace '<br>', '{br/}'
        $result = $result -replace '<br/>', '{br/}'
        $result = $result -replace '<br />', '{br/}'

        $result = $result -replace '<strong>', '{strong}'
        $result = $result -replace '</strong>', '{/strong}'
        $result = $result -replace '<b>', '{b}'
        $result = $result -replace '</b>', '{/b}'
        $result = $result -replace '<i>', '{i}'
        $result = $result -replace '</i>', '{/i}'
        $result = $result -replace '<h1>', '{h1}'
        $result = $result -replace '</h1>', '{/h1}'
        $result = $result -replace '<h2>', '{h2}'
        $result = $result -replace '</h2>', '{/h2}'
        $result = $result -replace '<h3>', '{h3}'
        $result = $result -replace '</h3>', '{/h3}'
        $result = $result -replace '<p>', '{p}'
        $result = $result -replace '</p>', '{/p}'
        $result = $result -replace '<pre>', '{pre}'
        $result = $result -replace '</pre>', '{/pre}'
        $result = $result -replace '<ul>', '{ul}'
        $result = $result -replace '</ul>', '{/ul}'
        $result = $result -replace '<ol>', '{ol}'
        $result = $result -replace '</ol>', '{/ol}'
        $result = $result -replace '<li>', '{li}'
        $result = $result -replace '</li>', '{/li}'

        # Encode the string
        [string]$result = [System.Web.HttpUtility]::HtmlEncode($result)

        # Replace the placeholders with the original tags
        $result = $result -replace '{br/}', '<br/>'
        $result = $result -replace '{strong}', '<strong>'
        $result = $result -replace '{/strong}', '</strong>'
        $result = $result -replace '{b}', '<b>'
        $result = $result -replace '{/b}', '</b>'
        $result = $result -replace '{i}', '<i>'
        $result = $result -replace '{/i}', '</i>'
        $result = $result -replace '{h1}', '<h1>'
        $result = $result -replace '{/h1}', '</h1>'
        $result = $result -replace '{h2}', '<h2>'
        $result = $result -replace '{/h2}', '</h2>'
        $result = $result -replace '{h3}', '<h3>'
        $result = $result -replace '{/h3}', '</h3>'
        $result = $result -replace '{p}', '<p>'
        $result = $result -replace '{/p}', '</p>'
        $result = $result -replace '{pre}', '<pre>'
        $result = $result -replace '{/pre}', '</pre>'
        $result = $result -replace '{ul}', '<ul>'
        $result = $result -replace '{/ul}', '</ul>'
        $result = $result -replace '{ol}', '<ol>'
        $result = $result -replace '{/ol}', '</ol>'
        $result = $result -replace '{li}', '<li>'
        $result = $result -replace '{/li}', '</li>'
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  Get-HtmlEncoded -taggedString 'This is <b>bold</b> and this > > not'
}
