Import-Module ./EulandaConnect.psm1

Describe 'New-Snapshot' {

    BeforeAll {
        $isAdmin = Test-Administrator
        if (-not $isAdmin) {
            Write-Warning "These tests require administrator rights. Run the tests as administrator."
        }
        if ($isAdmin) {
            $script:snapshot = New-Snapshot -volume 'C:'
        }
    }

    It 'Creates a snapshot of the C: drive' {
        if (-not $isAdmin) {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }

        $script:snapshot | Should -Not -BeNullOrEmpty
        $script:snapshot.volume | Should -Be 'C:'
    }

    AfterAll {
        if ($isAdmin) {
            Remove-Snapshot -snapshot $script:snapshot
        }
    }
}
