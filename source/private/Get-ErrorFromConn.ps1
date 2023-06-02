function Get-ErrorFromConn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [object]$conn = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'conn', $myInvocation.Mycommand))
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        New-Variable -Name 'description' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'err' -Scope 'Private' -Value ($null)
        New-Variable -Name 'i' -Scope 'Private' -Value ([int32]0)
        New-Variable -Name 'result' -Scope 'Private' -Value ([string]'')
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        if ($conn -and $conn.ConnectionString) {
            for ($i = 0; $i -lt $conn.Errors.Count; $i++) {
                $err = $conn.Errors.Item($i)
                $description = $err.Description

                # Check if the error description contains the relevant part
                if ($description -match '\[VENDOR:CNSOFT\]\[ADDRESS:USER\]\[LANGUAGE:DE\]\[PROC:<unknown_proc>\](.*)') {
                    $result = $Matches[1].Trim()
                    break
                }
            }
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Because its private function the test is like this:
    # Test:  $Features = Import-Module -Name '.\EulandaConnect.psm1' -PassThru -Force
    #        $myConn = Get-Conn -udl 'C:\temp\EULANDA_1 Truccamo.udl'
    #        $myConn.execute("Select *") # force an error
    #        & $Features {  Get-ErrorFromConn -conn $myConn -debug }
}
