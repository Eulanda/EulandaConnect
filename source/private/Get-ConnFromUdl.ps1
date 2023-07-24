function Get-ConnFromUdl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'udl', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'conn' -Scope 'Private' -Value ($null)
    }

    process {
        $conn = new-object -comObject ADODB.Connection
        $conn.CursorLocation = $adUseClient
        $conn.ConnectionString = "File Name=$(Resolve-Path $udl)"
        $conn.CommandTimeout = $adTimeout
        $conn.open()
    }

    end {
        Return $conn
    }

    <# Test:
        $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
        & $Features {  $conn = Get-ConnFromUdl -udl '.\source\tests\pester.udl'; $conn.State; $conn.close() }
    #>
}
