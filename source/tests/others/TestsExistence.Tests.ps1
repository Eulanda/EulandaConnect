Import-Module -Name .\EulandaConnect.psd1

Describe 'TestsExistence' {
    BeforeAll {
        $publicPath = '.\source\public\'
        $publicTestPath = '.\source\tests\public\'

        $privatePath = '.\source\private\'
        $privateTestPath = '.\source\tests\private\'

        $othersTestPath = '.\source\tests\others\'


        function Test-Existence {
            param(
                [Parameter(Mandatory = $true)]
                [string]$srcPath,

                [Parameter(Mandatory = $true)]
                [string]$testPath
            )

            $srcFiles = Get-ChildItem -Path $srcPath -Filter '*.*' -Recurse
            $testFiles = Get-ChildItem -Path $testPath -Filter '*.*' -Recurse


            $missingTests = @()


            foreach ($srcFile in $srcFiles) {
                if (-not ($testFiles.FullName -Match $srcFile.BaseName)) {
                    $missingTests += $srcFile.Name
                }
            }

            return $missingTests
        }

        function Test-DuplicateNamesAndNamingConvention {
            param(
                [Parameter(Mandatory = $true)]
                [string[]]$testPaths
            )

            $allTestFiles = $testPaths | ForEach-Object {
                Get-ChildItem -Path $_ -Filter '*.*' -Recurse
            }

            $duplicates = @()
            $duplicates += $allTestFiles | Group-Object -Property BaseName | Where-Object { $_.Count -gt 1 }

            $invalidNames = @()
            $invalidNames += $allTestFiles | Where-Object { ($_.Extension -eq '.ps1' -and $_.Name -notmatch '.+\.Tests\.ps1$') -or ($_.Extension -ne '.ps1') }

            return @{
                Duplicates = $duplicates
                InvalidNames = $invalidNames
            }
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


    It 'Test files in tests directories do not have duplicate names and follow naming convention' {
        $allPaths = $publicTestPath, $privateTestPath, $othersTestPath
        $result = Test-DuplicateNamesAndNamingConvention -testPath $allPaths
        if ($result.Duplicates.Count -gt 0) {
            Write-Warning "The following files have duplicate names:`r`n$($result.Duplicates | ForEach-Object { $_.Group.Name -join "`r`n" })"
        }
        if ($result.InvalidNames.Count -gt 0) {
            Write-Warning "The following files have invalid names:`r`n$($result.InvalidNames.Name -join "`r`n")"
        }
        $result.Duplicates | Should -BeNullOrEmpty
        $result.InvalidNames | Should -BeNullOrEmpty
    }

}

