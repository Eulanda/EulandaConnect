Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-AddressSql' -Tag 'eulanda' {

    It "generates valid SQL without parameters" {
        $sql = Get-AddressSql
        $expectedSql = "SELECT Match \[ID\.ALIAS\]"
        $sql | Should -Match $expectedSql
    }

    It "applies filter correctly" {
        $sql = Get-AddressSql -filter "Name1='John Doe'"
        $sql | Should -Match "WHERE \( RTrim\(LTrim\(IsNull\(Match,''\)\)\)  <> ''\) AND Name1='John Doe'"
    }

    It "handles limit parameter correctly" {
        $sql = Get-AddressSql -limit 100
        $sql | Should -Match "TOP 100"
    }

    It "handles order parameter correctly" {
        $sql = Get-AddressSql -order "Match"
        $sql | Should -Match "ORDER BY dummy.Match"
    }

    It "handles revers parameter correctly" {
        $sql = Get-AddressSql -revers
        $sql | Should -Match "ORDER BY dummy.Match DESC"
    }

    It "handles noIdAlias parameter correctly" {
        $sql = Get-AddressSql -noIdAlias
        $sql | Should -Not -Match "Match \[ID.ALIAS\]"
    }

    It "handles strCase parameter correctly" {
        $sql = Get-AddressSql -strCase "upper"
        $sql | Should -Match "SELECT MATCH"
        $sql | Should -Match "FROM ADRESSE"
    }

    It "handles reorder parameter correctly" {
        $sql = Get-AddressSql -reorder
        $sql | Should -Match "SELECT Match \[ID.ALIAS\], .*"
    }
}
