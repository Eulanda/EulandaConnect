Import-Module -Name .\EulandaConnect.psd1

Describe 'ConvertTo-WindowsLineEndingsFile' {
    InModuleScope EulandaConnect {

        BeforeAll {
            $tempFolder = [System.IO.Path]::GetTempPath()
            $randomFileName = [System.IO.Path]::GetRandomFileName() + ".txt"
            $tempFilePath = Join-Path -Path $tempFolder -ChildPath $randomFileName
            $tempFilePathCRLF = Join-Path -Path $tempFolder -ChildPath ([System.IO.Path]::GetRandomFileName() + ".txt")
            $testContent = "Line 1`nLine 2`nLine 3`n"
            $testContent | Set-Content -Path $tempFilePath -Encoding UTF8 -NoNewline
            $testContentCRLF = $testContent -replace "`n", "`r`n"
            $testContentCRLF | Set-Content -Path $tempFilePathCRLF -Encoding UTF8 -NoNewline
        }

        It "should convert the file to Windows line break format" {

            ConvertTo-WindowsLineEndingsFile -Path $tempFilePath

            # Verify that the file has the correct format
            $convertedContent = Get-Content -Path $tempFilePath -Raw
            $crCount = ($convertedContent.ToCharArray() | Where-Object { $_ -eq [char]13 }).Count
            $lfCount = ($convertedContent.ToCharArray() | Where-Object { $_ -eq [char]10 }).Count

            # Verify that the line break format was converted correctly
            $crCount | Should -Be 3
            $lfCount | Should -Be 3
        }


        It "should leave a file with CRLF line breaks unchanged" {

            ConvertTo-WindowsLineEndingsFile -Path $tempFilePathCRLF

            # Verify that the file remains unchanged
            $convertedContentCRLF = Get-Content -Path $tempFilePathCRLF -Raw
            $convertedContentCRLF | Should -Be $testContentCRLF
        }

        AfterAll {
            # Delete the temporary test files
            Remove-Item -Path $tempFilePath -Force
            Remove-Item -Path $tempFilePathCRLF -Force -ErrorAction SilentlyContinue
        }
    }
}
