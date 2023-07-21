Import-Module -Name .\EulandaConnect.psd1

Describe "Approve-Signature" -Tag 'integration', 'token' {
    # Prepare test
    BeforeAll {
        # Creating a Temp Folder
        $tempFolder = Join-Path $env:TEMP 'EulandaConnect'
        New-Item -ItemType Directory -Force -Path $tempFolder | Out-Null

        # Create Test File
        $testFilePath = Join-Path $tempFolder 'test.ps1'
        'Write-Host "Hello, World!"' | Out-File -FilePath $testFilePath
    }

    It "Creates, signs, verifies and deletes a file" {
        # Sign the file
        Approve-Signature -Path $testFilePath

        # Read the file
        $content = Get-Content -Path $testFilePath

        # Check if the signature is found
        $content -join "`n" | Should -Match "(?s)# SIG # Begin signature block.*# SIG # End signature block"

        # Delete the file
        Remove-Item -Path $testFilePath
    }

    # Clean up after test
    AfterAll {
        Remove-Item -Path $tempFolder -Force -Recurse
    }
}
