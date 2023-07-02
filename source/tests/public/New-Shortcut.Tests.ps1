Import-Module -Name .\EulandaConnect.psd1

Describe 'New-Shortcut' {

    BeforeAll {
        # Set test parameters
        $TestFile = 'C:\Windows\System32\notepad.exe'
        $TestLink = "$(Get-DesktopDir)\NotePadTest.lnk"
    }

    AfterEach {
        # Cleanup: Delete test link
        if (Test-Path $TestLink) {
            Remove-Item -Path $TestLink -ErrorAction SilentlyContinue
        }
    }

    It 'Creates a shortcut if the destination file exists' {
        New-Shortcut -file $TestFile -link $TestLink
        # The test is successful if the shortcut was created
        Test-Path $TestLink | Should -BeTrue
    }

    It 'Throws an error if the destination file does not exist' {
        { New-Shortcut -file 'NonExistentFile' -link $TestLink -ErrorAction Stop } | Should -Throw
    }
}
