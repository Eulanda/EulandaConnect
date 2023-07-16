Import-Module -Name .\EulandaConnect.psd1

Describe 'New-SymbolicLink' {
    BeforeAll {
        $isAdmin = Test-Administrator
        if (-not $isAdmin) {
            Write-Warning "These tests require administrator rights. Run the tests as administrator."
        }

        if ($isAdmin) {
            $global:TestSymbolicLink = "$env:TEMP\MySymbolicLink"
            $global:TestTarget = "$env:TEMP\MyTargetFile.txt"

            # Create a file to be the target of the symbolic link
            New-Item -Path $global:TestTarget -ItemType File -Force
        }
    }

    It 'New-SymbolicLink creates a symbolic link' {
        if (-not $isAdmin) {
            Set-ItResult -Skipped -Because 'Test requires administrator rights'
            return
        }

        New-SymbolicLink -symbolicLink $global:TestSymbolicLink -target $global:TestTarget -flag 0
        Test-Path -Path $global:TestSymbolicLink | Should -BeTrue
    }

    AfterAll {
        if ($isAdmin) {
            if (Test-Path -Path $global:TestSymbolicLink) {
                Remove-Item -Path $global:TestSymbolicLink -Force -ErrorAction SilentlyContinue
            }
            if (Test-Path -Path $global:TestTarget) {
                Remove-Item -Path $global:TestTarget -Force -ErrorAction SilentlyContinue
            }
        }
    }
}
