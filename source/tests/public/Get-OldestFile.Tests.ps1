Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-OldestFile' {

    BeforeAll {
        # Create a temporary path
        $testPath = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath "EulandaConnectTest"
        New-Item -Path $testPath -ItemType Directory -Force

        # Create some test files with different timestamps
        $testFiles = @(
            New-Item -Path (Join-Path -Path $testPath -ChildPath "Test1.txt") -ItemType File -Force
            New-Item -Path (Join-Path -Path $testPath -ChildPath "Test2.txt") -ItemType File -Force
            New-Item -Path (Join-Path -Path $testPath -ChildPath "Test3.txt") -ItemType File -Force
        )

        # Patch files with different ages
        $testFiles[0].LastWriteTime = (Get-Date).AddDays(-3)
        $testFiles[1].LastWriteTime = (Get-Date).AddDays(-1)
        $testFiles[2].LastWriteTime = (Get-Date).AddDays(-2)
    }

    It "Returns the oldest file in a directory" {
        $expectedResult = "Test1.txt"
        $result = Get-OldestFile -path $testPath
        $result | Should -Be $expectedResult
    }

    AfterAll {
        Remove-Item -Path $testPath -Recurse -Force
    }
}
