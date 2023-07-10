Import-Module ./EulandaConnect.psm1

Describe 'Convert-DatanormToXml Integration Test' {


    BeforeAll {
        $datanorm = @{
            a = @{
                values = @(
                    @{
                        ArtikelNummer = '8241335';
                        Preis = '10.5';
                        PreisKennzeichen = '1';
                        PreisEinheit = '1';
                        MengenEinheit = 'L';
                        RabattGruppe = 'R1';
                        WarenhauptGruppe = 'W1';
                        Kurztext1 = 'Article 1';
                        Kurztext2 = 'Description 1';
                    }
                )
            };
            b = @{
                '8241335' = @{
                    Matchcode = 'M1';
                    EuroArtikelNummer = 'EAN1';
                    AlternativArtikelNummer = 'AA1';
                    VerpackungsMenge = '10';
                    EUL_CuAufschlagProStueck = '0.5';
                }
            };
            p = @{
                values = @()
            }
        }
    }


    It 'should converts a datanorm object to XML correctly' {
        $xml = Convert-DatanormToXml -datanorm $datanorm
        $xml | Should -Not -BeNullOrEmpty
        $xml | Should -Match "<EULANDA"
        $xml | Should -Match "<ARTIKELLISTE>"
        $xml | Should -Match "</ARTIKELLISTE>"
        $xml | Should -Match "8241335"
    }
}
