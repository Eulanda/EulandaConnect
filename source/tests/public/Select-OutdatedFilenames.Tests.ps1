Import-Module .\EulandaConnect.psd1

Describe "Select-OutdatedFilenames function Test" {

    BeforeAll {
        # Set temp directory
        $testDirectory = Join-Path (Get-TempDir) "Select-OutdatedFilenamesTest"

        # Create the temp directory if it doesn't exist
        if (!(Test-Path -Path $testDirectory)) {
            New-Item -ItemType Directory -Path $testDirectory | Out-Null
        }
    }

    BeforeEach {
        # Generate 10 random timestamps and file names
        1..10 | ForEach-Object {
            $timestamp = (Get-Date).AddDays(-$_).ToString("yyyy-MM-dd-HH-mm-ss-ffff")
            $filename = "myfile-$timestamp.txt"
            $fullPath = Join-Path $testDirectory $filename
            Set-Content -Path $fullPath -Value "test" -Force
        }
    }

    AfterEach {
        # Clean up files after each test
        Get-ChildItem -Path $testDirectory -File | Remove-Item -Force
    }

    AfterAll {
        # Clean up the temp directory after all tests
        Remove-Item -Path $testDirectory -Force
    }

    It "Should select 6 oldest files when history is set to 4" {
        $allFiles = Get-ChildItem -Path $testDirectory -File | ForEach-Object { $_.Name }
        $outdatedFiles = Select-OutdatedFilenames -filenames $allFiles -basename "myfile" -extension "txt" -history 4

        # Check the number of outdated files
        $outdatedFiles.Count | Should -Be 6

        # Check that the selected files are the oldest
        $allFilesSorted = $allFiles | Sort-Object { [datetime]::ParseExact(($_ -replace 'myfile-(.*).txt', '$1'), "yyyy-MM-dd-HH-mm-ss-ffff", $null) }
        $expectedOutdatedFiles = $allFilesSorted | Select-Object -First 6
        $outdatedFiles | Should -Be $expectedOutdatedFiles
    }
}
