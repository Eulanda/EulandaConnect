Import-Module -Name .\EulandaConnect.psd1

Describe 'ConvertTo-UnixLineEndingsFile' {
    InModuleScope EulandaConnect {

        BeforeAll {
            $tempFolder = [System.IO.Path]::GetTempPath()
            $randomFileName = [System.IO.Path]::GetRandomFileName() + ".txt"
            $tempFilePath = Join-Path -Path $tempFolder -ChildPath $randomFileName
            $tempFilePathLF = Join-Path -Path $tempFolder -ChildPath ([System.IO.Path]::GetRandomFileName() + ".txt")
            $testContentCRLF = "Line 1`r`nLine 2`r`nLine 3`r`n"
            $testContentCRLF | Set-Content -Path $tempFilePath -Encoding UTF8 -NoNewline
            $testContentLF = $testContentCRLF -replace "`r`n", "`n"
            $testContentLF | Set-Content -Path $tempFilePathLF -Encoding UTF8 -NoNewline
        }

        It "should convert the file to Unix line break format" {

            ConvertTo-UnixLineEndingsFile -Path $tempFilePath

            # Verify that the file has the correct format
            $convertedContent = Get-Content -Path $tempFilePath -Raw
            $charArray = $convertedContent.ToCharArray()

            $crCount = if ($charArray) { $charArray | Where-Object { $_ -eq [char]13 } | Measure-Object | Select-Object -ExpandProperty Count } else { 0 }
            $lfCount = if ($charArray) { $charArray | Where-Object { $_ -eq [char]10 } | Measure-Object | Select-Object -ExpandProperty Count } else { 0 }

            # Verify that the line break format was converted correctly
            $crCount | Should -Be 0
            $lfCount | Should -Be 3
        }

        It "should leave a file with LF line breaks unchanged" {

            ConvertTo-UnixLineEndingsFile -Path $tempFilePathLF

            # Verify that the file remains unchanged
            $convertedContentLF = Get-Content -Path $tempFilePathLF -Raw
            $convertedContentLF | Should -Be $testContentLF
        }

        AfterAll {
            # Delete the temporary test files
            Remove-Item -Path $tempFilePath -Force
            Remove-Item -Path $tempFilePathLF -Force -ErrorAction SilentlyContinue
        }
    }
}
