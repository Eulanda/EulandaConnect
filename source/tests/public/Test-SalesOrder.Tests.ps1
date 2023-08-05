Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-SalesOrder' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

          . source\tests\include\Include-InsertAddress.ps1

          $myConn = Get-Conn -udl ".\source\tests\Eulanda_1 Pester.udl"

        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Close sales order from sales order no and check status' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        # Prepare
        $salesOrderId = New-SalesOrder -invoiceAddressId $addressId -conn $myConn
        $sql = "SELECT TOP 1 KopfNummer FROM Auftrag ORDER BY ID DESC"
        $rs = $myConn.Execute($sql)
        $salesOrderNo = 0
        if (($rs) -and (!$rs.eof)) {
            $salesOrderNo = $rs.fields(0).value
            $rs.close()
        }

        # Act
        $salesOrderExists = Test-SalesOrder -salesOrderNo $salesOrderNo -conn $myConn
        $salesOrderExists | should -BeTrue

        # Cleanup
        $sql = "DELETE Auftrag WHERE Id = $salesOrderId"
        $myConn.Execute($sql) | Out-Null
    }

}
