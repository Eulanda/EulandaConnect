Import-Module -Name .\EulandaConnect.psd1

Describe 'New-TempDir' {

    It 'Creates a new temp directory' {
        $tempDir = New-TempDir
        Test-Path -Path $tempDir | Should -BeTrue
    }

    AfterEach {
        # Cleanup the created temp directory
        if (Test-Path -Path $tempDir) {
            Remove-Item -Path $tempDir -Recurse -Force
        }
    }
}
