function Get-ConnFromStr {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'connStr', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'conn' -Scope 'Private' -Value ($null)
    }

    process {
        $conn = new-object -comObject ADODB.Connection
        $conn.CursorLocation = $adUseClient
        $conn.ConnectionString = $connStr
        $conn.CommandTimeout = $adTimeout
        $conn.open()
    }

    end {
        Return $conn
    }
    <# Test:
        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features { $conn = Get-ConnFromStr -connStr 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=master;Data Source=.\PESTER'; $conn.State; $conn.close() }
    #>
}
