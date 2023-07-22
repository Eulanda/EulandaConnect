Import-Module -Name .\EulandaConnect.psd1
Set-StrictMode -version latest

Describe 'Get-ArticleSql' -Tag 'eulanda' {

    It "generates valid SQL without parameters" {
        $sql = Get-ArticleSql
        $expectedSql = "SELECT ArtNummer \[ID\.ALIAS\]"
        $sql | Should -Match $expectedSql
    }


    It "applies filter correctly" {
        $sql = Get-ArticleSql -filter "ArtNummer='130100'"
        $sql | Should -Match "WHERE \( RTrim\(LTrim\(IsNull\(ArtNummer,''\)\)\)  <> ''\) AND ArtNummer='130100'"
    }

    It "handles limit parameter correctly" {
        $sql = Get-ArticleSql -limit 100
        $sql | Should -Match "TOP 100"
    }

    It "handles order parameter correctly" {
        $sql = Get-ArticleSql -order "ArtNummer"
        $sql | Should -Match "ORDER BY dummy.ArtNummer"
    }

    It "handles revers parameter correctly" {
        $sql = Get-ArticleSql -revers
        $sql | Should -Match "ORDER BY dummy.ArtNummer DESC"
    }

    It "handles noIdAlias parameter correctly" {
        $sql = Get-ArticleSql -noIdAlias
        $sql | Should -Not -Match "ArtNummer \[ID.ALIAS\]"
    }

    It "handles strCase parameter correctly" {
        $sql = Get-ArticleSql -strCase "upper"
        $sql | Should -Match "SELECT ArtNummer \[ID.ALIAS\], .*"
        $sql | Should -Match "FROM ARTIKEL"
    }

    It "handles reorder parameter correctly" {
        $sql = Get-ArticleSql -reorder
        $sql | Should -Match "SELECT ArtNummer \[ID.ALIAS\], .*"
    }
}
