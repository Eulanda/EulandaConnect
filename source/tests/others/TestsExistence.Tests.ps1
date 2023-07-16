Import-Module -Name .\EulandaConnect.psd1

Describe 'TestsExistence' {
    BeforeAll {
        $publicPath = '.\source\public\'
        $publicTestPath = '.\source\tests\public\'

        $privatePath = '.\source\private\'
        $privateTestPath = '.\source\tests\private\'

        function Test-Existence {
            param(
                [Parameter(Mandatory = $true)]
                [string]$srcPath,

                [Parameter(Mandatory = $true)]
                [string]$testPath
            )

            $srcFiles = Get-ChildItem -Path $srcPath -Filter '*.ps1' -Recurse
            $testFiles = Get-ChildItem -Path $testPath -Filter '*.ps1' -Recurse

            $missingTests = @()


            foreach ($srcFile in $srcFiles) {
                if (-not ($testFiles.FullName -Match $srcFile.BaseName)) {
                    $missingTests += $srcFile.Name
                }
            }

            return $missingTests
        }
    }

    It 'Public functions have Pester tests' {
        $missingTests = Test-Existence -srcPath $publicPath -testPath $publicTestPath
        if ($missingTests.Count -gt 0) {
            $totalPublicFunctions = (Get-ChildItem -Path $publicPath -Filter '*.ps1' -Recurse).Count
            $percentageMissing = [int](($missingTests.Count / $totalPublicFunctions) * 100)
            Write-Warning "The following public functions are missing Pester tests:`r`n$($missingTests -join "`r`n")"
            Write-Warning "$percentageMissing% of public functions are missing tests."
            Set-ItResult -Skipped -Because 'Some public functions are missing Pester tests'
        } else {
            Write-Host "All public functions have an Pester test"
        }
    }

    It 'Private functions have Pester tests' {
        $missingTests = Test-Existence -srcPath $privatePath -testPath $privateTestPath
        if ($missingTests.Count -gt 0) {
            $totalPrivateFunctions = (Get-ChildItem -Path $privatePath -Filter '*.ps1' -Recurse).Count
            $percentageMissing = [int](($missingTests.Count / $totalPrivateFunctions) * 100)
            Write-Host
            Write-Warning "The following private functions are missing Pester tests:`r`n$($missingTests -join "`r`n")"
            Write-Warning "$percentageMissing% of private functions are missing tests."
            Set-ItResult -Skipped -Because 'Some private functions are missing Pester tests'
        } else {
            Write-Warning "All private functions have an Pester test"
        }
    }
}

