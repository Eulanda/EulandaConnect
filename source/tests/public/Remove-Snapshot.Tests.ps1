Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Remove-Snapshot' -Tag 'admin' {

    BeforeAll {
        $isAdmin = Test-Administrator
        if (-not $isAdmin) {
            Write-Warning "These tests require administrator rights. Run the tests as administrator."
        }
        if ($isAdmin) {
            $script:snapshot = New-Snapshot -volume 'C:'
        }
    }

    It 'Removes the snapshot of the C: drive' {
        if (-not $isAdmin) {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }

        Remove-Snapshot -snapshot $script:snapshot
        # We expect the symbolic link no longer exists
        Test-Path $script:snapshot.symbolicLink | Should -BeFalse
    }
}
