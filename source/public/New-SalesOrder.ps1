function New-SalesOrder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateId -id $_ })]
        [int]$invoiceAddressId = $(Throw ((Get-ResStr 'PARAM_MANDATORY_MISSED') -f 'invoiceAddressId', $myInvocation.Mycommand))
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConn -conn $_  })]
        $conn
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidatePathUDL -path $_  })]
        [string]$udl
        ,
        [Parameter(Mandatory = $false)]
        [ValidateScript({ Test-ValidateConnStr -connStr $_ })]
        [string]$connStr
    )

    begin {
        Write-Verbose -Message ((Get-ResStr 'STARTING_FUNCTION') -f $myInvocation.Mycommand)
        Test-ValidateSingle -validParams (Get-SingleConnection) @PSBoundParameters
        New-Variable -Name 'myConn' -Scope 'Private' -Value ($null)
        New-Variable -Name 'rs' -Scope 'Private' -Value ($null)
        New-Variable -Name 'sql' -Scope 'Private' -Value ([string]'')
        New-Variable -Name 'result' -Scope 'Private' -Value ([int32]0)
        $initialVariables = Get-CurrentVariables -Debug:$DebugPreference
    }

    process {
        $myConn = Get-Conn -conn $conn -udl $udl -connStr $connStr
        # Create an empty sales order head
        [string]$sql = "SET NOCOUNT ON`r`n" +`
            "DECLARE @Af_Id int`r`n" +`
            "DECLARE @Ad_Id int`r`n" +`
            "SET @Ad_Id = $invoiceAddressId`r`n" +`
            "EXEC dbo.cn_CreAf @Af_Id = @Af_Id out, @Ad_Id = @Ad_Id`r`n" +`
            "SELECT @Af_Id [Id]"

        $rs = new-object -comObject ADODB.Recordset
        $rs.CursorLocation = $adUseClient
        try {
            $rs.Open($sql, $myConn, $adOpenKeyset, $adLockOptimistic, $adCmdText)
        }
        catch {
            if ($myConn.Errors.count -gt 0) {
                $errMessage = ""
                foreach ($e in $myConn.Errors) {
                    $errMessage = $errMessage + " " + $e.description
                }
                $errMessage = $errMessage.Trim()
                try {
                    $myConn.close()
                }
                catch {
                }
                Throw "$errMessage"
            } else { Throw $_ }
        }


        # Toggle all record sets until you find an open one
        Do {
            If ($rs.State -ne $adStateOpen) {
                $rs = $rs.NextRecordset()
            }
        } until ( (! $rs) -or ($rs.State -eq $adStateOpen) )

        # Get the id of the new order
        if (! $rs.eof) {
            [int]$result = $rs.fields('Id').value
        }
    }

    end {
        Get-CurrentVariables -InitialVariables $initialVariables -Debug:$DebugPreference
        Return $result
    }
    # Test:  New-SalesOrder -invoiceAddressId 3 -udl 'C:\temp\EULANDA_1 Truccamo.udl'
}
