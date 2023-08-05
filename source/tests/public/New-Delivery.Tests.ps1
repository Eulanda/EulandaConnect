Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'New-Delivery' -Tag 'integration', 'sql', 'sqladmin', 'eulanda' {

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


    It 'Creates delivery note from open sales order must throw' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        # Prepare
        . source\tests\include\Include-InsertAddress.ps1
        $myConn = Get-Conn -udl ".\source\tests\Eulanda_1 Pester.udl"
        $salesOrderId = New-SalesOrder -invoiceAddressId $addressId -conn $myConn

        # Act
        { New-Delivery -salesOrderId $salesOrderId -conn $myConn } | Should -Throw

        # Cleanup
        $myConn.Close()
        Restore-MssqlDatabase -udl $udl
    }

    It 'Creates delivery note from empty sales order must throw' {
        if ($skipTest) {
            Set-ItResult -Skipped -Because 'This test should be skipped due to user not in sysadmin role'
            Return
        }

        # Prepare
        . source\tests\include\Include-InsertAddress.ps1
        $myConn = Get-Conn -udl ".\source\tests\Eulanda_1 Pester.udl"
        $salesOrderId = New-SalesOrder -invoiceAddressId $addressId -conn $myConn
        Close-SalesOrder -salesOrderId $salesOrderId -conn $myConn

        # Act
        { New-Delivery -salesOrderId $salesOrderId -conn $myConn } | Should -Throw

        # Cleanup
        $myConn.Close()
        Restore-MssqlDatabase -udl $udl
    }

    It 'Creates delivery note from sales order must not throw' {
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

        # ACT
        $deliveryId = New-Delivery -salesOrderId $salesOrderId -conn $myConn
        $deliveryId | Should -BeGreaterThan 0

        # CLEANUP
        $myConn.Close()
        Restore-MssqlDatabase -udl $udl
    }

}
