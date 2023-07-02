Import-Module -Name .\EulandaConnect.psd1

Describe 'Get-StockSql' {

    # Test 1: Check if the output array has 3 elements
    It 'returns an array with 3 elements' {
        $arrayInput = @('abc', 'def', 'ghi')
        $output = Get-StockSql -filter $arrayInput
        $output.Count | Should -Be 3
    }

    # Test 2: Check if the output contains the specific ArtNummer
    It 'contains specific ArtNummer in the SQL query' {
        $output = Get-StockSql -filter "ArtNummer='130100'"
        $outputJoined = $output -join ' '
        $outputJoined | Should -Match '130100'
    }

    # Test 3: Check if the output contains 'BESTANDVERFUEGBAR1' when the legacy switch is set
    It 'contains BESTANDVERFUEGBAR1 in the SQL query when legacy switch is set' {
        $output = Get-StockSql -legacy $true
        $outputJoined = $output -join ' '
        $outputJoined | Should -Match 'BESTANDVERFUEGBAR1'
    }
}
