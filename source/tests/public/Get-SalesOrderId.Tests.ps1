Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-SalesOrderId' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl

          . source\tests\include\Include-InsertAddress.ps1

          $myConn = Get-Conn -udl ".\source\tests\Eulanda_1 Pester.udl"
          $id = New-SalesOrder -invoiceAddressId $addressId -conn $myConn
          $sql = "SELECT TOP 1 KopfNummer FROM Auftrag ORDER BY ID DESC"
          $rs = $myConn.Execute($sql)
          $salesOrderNo = 0
          if (($rs) -and (!$rs.eof)) {
              $salesOrderNo = $rs.fields(0).value
          }

        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Get sales order id from sales order no' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        $idGet = Get-SalesOrderId -salesOrderNo $salesOrderNo -conn $myConn
        ($id -$idGet)| should -Be 0
    }

}
