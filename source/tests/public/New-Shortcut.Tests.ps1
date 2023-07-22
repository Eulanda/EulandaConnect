Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'New-Shortcut' {

    BeforeAll {
        $TestFile = 'C:\Windows\System32\notepad.exe'
        $TestLink = "$(Get-DesktopDir)\NotePadTest.lnk"
    }

    It 'Creates a shortcut if the destination file exists' {
        New-Shortcut -file $TestFile -link $TestLink
        # The test is successful if the shortcut was created
        Test-Path $TestLink | Should -BeTrue
    }

    It 'Throws an error if the destination file does not exist' {
        { New-Shortcut -file 'NonExistentFile' -link $TestLink -ErrorAction Stop } | Should -Throw
    }

    AfterEach {
        if (Test-Path $TestLink) {
            Remove-Item -Path $TestLink -ErrorAction SilentlyContinue
        }
    }
}
