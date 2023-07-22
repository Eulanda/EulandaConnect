Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Test-Website' -Tag 'integration', 'https' {

    BeforeAll {
        $result = Test-Website -url "https://eulandaconnect.eulanda.eu/"
    }

    It 'Returns more than 0 visited URLs' {
        $result.VisitedUrls.count | Should -BeGreaterThan 0
    }

    It 'Returns 0 NoIndex URLs' {
        $result.NoIndex.count | Should -Be 0
    }

    It 'Returns 0 NoFollow URLs' {
        $result.NoFollow.count | Should -Be 0
    }

    It 'Returns 0 Broken URLs' {
        $result.Broken.count | Should -Be 0
    }
}
