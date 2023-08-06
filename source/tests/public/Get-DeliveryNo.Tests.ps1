Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-DeliveryNo' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

    BeforeAll {
        $udl = Resolve-Path ".\source\tests\Eulanda_1 Pester.udl"

        # Test-MssqlAdministartor rights
        $skipTest = -not (Test-MssqlAdministrator -udl $udl)

        # Skip backup because for restoring you need special rights
        if (! $skipTest) {
            Backup-MssqlDatabase -udl $udl
        }
    }


    AfterAll {
        # Skip restore because for restoring you need special rights
        if (! $skipTest) {
            Restore-MssqlDatabase -udl $udl
        }
    }


    It 'Get delivery note number from an delivery note Id' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        # PREPARE
        . source\tests\include\Include-InsertAddress.ps1
        . source\tests\include\Include-InsertArticle.ps1
        $myConn = Get-Conn -udl ".\source\tests\Eulanda_1 Pester.udl"
        $salesOrderId = New-SalesOrder -invoiceAddressId $addressId -conn $myConn

        # Insert line item
        [int]$quantity = 1
        [string]$sql =  "SET NOCOUNT ON`r`n" +`
        "DECLARE @Af_Id int`r`n" +`
        "DECLARE @Ar_Id int`r`n" +`
        "DECLARE @Afp_menge numeric(18,4)`r`n" +`
        "DECLARE @Afp_id int`r`n" +`
        "SET @Af_Id = $salesOrderId`r`n" +`
        "SET @Ar_Id = $articleId`r`n" +`
        "SET @Afp_menge = $quantity`r`n" +`
        "EXEC dbo.cn_CreAfp @Afp_Id = @Afp_Id out, @Af_Id = @Af_Id, @Ar_Id = @Ar_Id, @Afp_Menge = @Afp_Menge`r`n" +`
        "SELECT @Afp_Id [Id]"
        $myConn.Execute($sql) | Out-Null

        # Book sales order
        Close-SalesOrder -salesOrderId $salesOrderId -conn $myConn

        # Create a new delivery note from an sales order
        $deliveryId = New-Delivery -salesOrderId $salesOrderId -conn $myConn

        # ACT
        $deliveryNo = Get-DeliveryNo -deliveryId $deliveryId -conn $myConn
        $deliveryNo | Should -BeGreaterThan 0

        # CLEANUP
        $myConn.Close()
        Restore-MssqlDatabase -udl $udl
    }

}
