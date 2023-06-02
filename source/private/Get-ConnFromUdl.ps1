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
        $conn.ConnectionString = "File Name=$udl"
        $conn.CommandTimeout = $adTimeout
        $conn.open()
    }

    end {
        Return $conn
    }
    # Because its private function the test is like this:
    # Test:  $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    #        & $Features {  Get-ConnFromUdl -udl 'C:\temp\Eulanda_1 Eulanda.udl' }

}
